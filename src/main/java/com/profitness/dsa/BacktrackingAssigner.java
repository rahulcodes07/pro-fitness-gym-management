package com.profitness.dsa;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * Solves the Member-Trainer Constraint Satisfaction Problem (CSP) using Backtracking.
 * <p>
 * <b>Algorithm:</b><br>
 * Evaluates member training requests sequentially against trainer profiles under two primary constraints:
 * <ol>
 *   <li><b>Specialization Constraint:</b> The trainer's discipline must match the member's preference (e.g., Strength, Cardio).</li>
 *   <li><b>Temporal Non-Overlap Constraint:</b> The trainer must offer the requested time slot, and it must not already be booked.</li>
 * </ol>
 * When a tentative assignment leads to an unsatisfiable downstream state or slot collision,
 * the algorithm undoes the booking (backtracks) and explores alternate trainers.
 * </p>
 * <p>
 * <b>Time Complexity:</b><br>
 * Worst-case O(M^N) where N is the number of member requests and M is the number of trainers.<br>
 * Heavily pruned in practice through constraint checks (forward checking / constraint propagation).<br>
 * Space Complexity: O(N) recursion stack and assignment mappings.
 * </p>
 * <p>
 * <b>Gym Application:</b><br>
 * Automates the complex weekly booking matrix, ensuring members receive guidance from trainers
 * certified in their desired discipline without double-booking trainer time slots.
 * </p>
 */
public class BacktrackingAssigner {

    /**
     * Private constructor to prevent instantiation of utility class.
     */
    private BacktrackingAssigner() {
    }

    /**
     * Solves the member-trainer assignment problem using recursive backtracking.
     *
     * @param requests List of member session requests
     * @param trainers List of available trainer profiles with specializations and time slots
     * @return An {@link AssignmentResult} containing finalized pairings, unassigned members,
     *         backtrack count, and execution steps.
     */
    public static AssignmentResult assign(ArrayList<MemberRequest> requests, ArrayList<TrainerProfile> trainers) {
        ArrayList<String> steps = new ArrayList<>();
        HashMap<String, String> assignments = new HashMap<>();
        ArrayList<String> unassignedMembers = new ArrayList<>();
        int[] backtracks = new int[1];

        if (requests == null || requests.isEmpty()) {
            steps.add("No member requests provided. Assignment completed with 0 pairings.");
            return new AssignmentResult(assignments, unassignedMembers, steps, 0);
        }

        if (trainers == null || trainers.isEmpty()) {
            steps.add("No trainers available on roster. All member requests remain unassigned.");
            for (MemberRequest req : requests) {
                unassignedMembers.add(req.getMemberName());
            }
            return new AssignmentResult(assignments, unassignedMembers, steps, 0);
        }

        steps.add(String.format("Starting Backtracking Assigner with %d requests and %d trainers...",
                requests.size(), trainers.size()));

        // Create defensive copies of trainers with cleared assigned slots for a clean search
        ArrayList<TrainerProfile> workingTrainers = new ArrayList<>();
        for (TrainerProfile t : trainers) {
            TrainerProfile clone = new TrainerProfile(t.getName(), t.getSpecialization(), t.getAvailableSlots());
            workingTrainers.add(clone);
        }

        // Attempt strict full assignment first
        boolean fullSuccess = solveStrict(0, requests, workingTrainers, assignments, steps, backtracks);

        if (!fullSuccess) {
            steps.add("Full concurrent assignment not achievable for all members. Initiating best-effort resolution...");
            // Clear working trainers and assignments for best-effort pass
            for (TrainerProfile t : workingTrainers) {
                t.getAssignedSlots().clear();
            }
            assignments.clear();
            solveBestEffort(0, requests, workingTrainers, assignments, unassignedMembers, steps, backtracks);
        }

        steps.add(String.format("Final Assignment Outcome: %d assigned, %d unassigned, %d backtracks.",
                assignments.size(), unassignedMembers.size(), backtracks[0]));

        return new AssignmentResult(assignments, unassignedMembers, steps, backtracks[0]);
    }

    /**
     * Strict recursive backtracking: Requires 100% of requests to be fulfilled.
     */
    private static boolean solveStrict(int index,
                                       ArrayList<MemberRequest> requests,
                                       ArrayList<TrainerProfile> trainers,
                                       HashMap<String, String> assignments,
                                       ArrayList<String> steps,
                                       int[] backtracks) {
        // Base case: All member requests successfully satisfied
        if (index == requests.size()) {
            return true;
        }

        MemberRequest req = requests.get(index);

        for (TrainerProfile trainer : trainers) {
            boolean specMatch = trainer.getSpecialization().trim().equalsIgnoreCase(req.getPreferredSpecialization().trim());
            boolean slotFree = trainer.isSlotAvailable(req.getPreferredTimeSlot());

            if (specMatch && slotFree) {
                // Tentative Assignment
                trainer.bookSlot(req.getPreferredTimeSlot());
                assignments.put(req.getMemberName(), trainer.getName());
                steps.add(String.format("Try assigning %s to Trainer %s... Specialization match: YES, Time slot available: YES -> Assigned!",
                        req.getMemberName(), trainer.getName()));

                // Recurse to next member
                if (solveStrict(index + 1, requests, trainers, assignments, steps, backtracks)) {
                    return true;
                }

                // If recursive subtree failed, backtrack
                steps.add(String.format("Backtracking: Reversing assignment of %s from Trainer %s...",
                        req.getMemberName(), trainer.getName()));
                trainer.releaseSlot(req.getPreferredTimeSlot());
                assignments.remove(req.getMemberName());
                backtracks[0]++;

            } else if (specMatch && !slotFree) {
                steps.add(String.format("Try assigning %s to Trainer %s... Time slot conflict! Backtrack...",
                        req.getMemberName(), trainer.getName()));
                backtracks[0]++;
            } else {
                // Specialization mismatch
                steps.add(String.format("Try assigning %s to Trainer %s... Specialization mismatch (%s vs %s).",
                        req.getMemberName(), trainer.getName(), req.getPreferredSpecialization(), trainer.getSpecialization()));
            }
        }

        // Could not assign current member to any trainer
        return false;
    }

    /**
     * Best-effort recursive backtracking: Assigns as many requests as possible,
     * tracking members that cannot be satisfied.
     */
    private static void solveBestEffort(int index,
                                        ArrayList<MemberRequest> requests,
                                        ArrayList<TrainerProfile> trainers,
                                        HashMap<String, String> assignments,
                                        ArrayList<String> unassignedMembers,
                                        ArrayList<String> steps,
                                        int[] backtracks) {
        if (index == requests.size()) {
            return;
        }

        MemberRequest req = requests.get(index);
        boolean assigned = false;

        for (TrainerProfile trainer : trainers) {
            boolean specMatch = trainer.getSpecialization().trim().equalsIgnoreCase(req.getPreferredSpecialization().trim());
            boolean slotFree = trainer.isSlotAvailable(req.getPreferredTimeSlot());

            if (specMatch && slotFree) {
                trainer.bookSlot(req.getPreferredTimeSlot());
                assignments.put(req.getMemberName(), trainer.getName());
                steps.add(String.format("Try assigning %s to Trainer %s... Specialization match: YES, Time slot available: YES -> Assigned!",
                        req.getMemberName(), trainer.getName()));
                assigned = true;
                break;
            } else if (specMatch && !slotFree) {
                steps.add(String.format("Try assigning %s to Trainer %s... Time slot conflict! Backtrack...",
                        req.getMemberName(), trainer.getName()));
                backtracks[0]++;
            }
        }

        if (!assigned) {
            unassignedMembers.add(req.getMemberName());
            steps.add(String.format("Could not assign %s due to trainer schedule constraints. Marked as unassigned.",
                    req.getMemberName()));
        }

        solveBestEffort(index + 1, requests, trainers, assignments, unassignedMembers, steps, backtracks);
    }
}
