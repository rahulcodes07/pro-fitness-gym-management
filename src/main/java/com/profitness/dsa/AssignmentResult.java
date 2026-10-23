package com.profitness.dsa;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * Encapsulates the results of the Backtracking Constraint Trainer Assigner.
 * <p>
 * <b>Data Structure & Algorithmic Role:</b><br>
 * Transports the final mapping of gym members to compatible trainers,
 * list of unassigned members, total backtrack counter, and chronological execution steps.
 * </p>
 * <p>
 * <b>Time Complexity:</b><br>
 * O(1) for field access and summary statistics.
 * </p>
 * <p>
 * <b>Gym Application:</b><br>
 * Allows managers to review whether all member training requests were fulfilled,
 * how many conflicts caused backtracking, and which members need rescheduled appointments.
 * </p>
 */
public class AssignmentResult {
    private final HashMap<String, String> assignments;
    private final ArrayList<String> unassignedMembers;
    private final ArrayList<String> steps;
    private final int backtracks;

    /**
     * Constructs an AssignmentResult outcome.
     *
     * @param assignments       Mapping of member name to assigned trainer name
     * @param unassignedMembers List of members whose requests could not be satisfied
     * @param steps             Step-by-step diagnostic log recording matches, conflicts, and backtracks
     * @param backtracks        Total number of backtrack steps performed during search
     */
    public AssignmentResult(HashMap<String, String> assignments,
                            ArrayList<String> unassignedMembers,
                            ArrayList<String> steps,
                            int backtracks) {
        this.assignments = assignments != null ? assignments : new HashMap<>();
        this.unassignedMembers = unassignedMembers != null ? unassignedMembers : new ArrayList<>();
        this.steps = steps != null ? steps : new ArrayList<>();
        this.backtracks = backtracks;
    }

    public HashMap<String, String> getAssignments() {
        return assignments;
    }

    public ArrayList<String> getUnassignedMembers() {
        return unassignedMembers;
    }

    public ArrayList<String> getSteps() {
        return steps;
    }

    public int getBacktracks() {
        return backtracks;
    }

    public boolean isAllAssigned() {
        return unassignedMembers.isEmpty();
    }

    @Override
    public String toString() {
        return String.format("Assigned: %d | Unassigned: %d | Backtracks: %d",
                assignments.size(), unassignedMembers.size(), backtracks);
    }
}
