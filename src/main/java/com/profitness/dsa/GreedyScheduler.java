package com.profitness.dsa;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * Implements a Greedy Interval Scheduling / Activity Selection algorithm
 * to schedule personal training sessions among available gym trainers.
 * <p>
 * <b>Algorithm:</b><br>
 * 1. Collect all incoming session requests.<br>
 * 2. Sort sessions in non-decreasing order of their completion time ({@code endTime}) from scratch.<br>
 * 3. Greedily assign each session to the first available trainer whose latest booked session ends
 *    before or when the current session starts (non-overlapping).<br>
 * 4. If all trainers are occupied during that interval, the session is marked as unscheduled.
 * </p>
 * <p>
 * <b>Time Complexity:</b><br>
 * O(N log N) for scratch merge sorting + O(N * M) for greedy assignment across M trainers.<br>
 * Space Complexity: O(N + M) auxiliary space for schedule buckets and sorted lists.
 * </p>
 * <p>
 * <b>Gym Application:</b><br>
 * Personal trainers are an expensive gym resource. Greedy activity selection guarantees
 * the theoretical maximum number of non-overlapping training sessions can be fulfilled
 * within available operational hours.
 * </p>
 */
public class GreedyScheduler {

    /**
     * Standard registered gym personal trainers.
     */
    public static final String[] DEFAULT_TRAINERS = {
            "Arjun", "Priya", "Vikram", "Neha", "Karthik"
    };

    /**
     * Private constructor to prevent instantiation of utility class.
     */
    private GreedyScheduler() {
    }

    /**
     * Schedules a list of session requests across the given number of trainers
     * using the Greedy Activity Selection principle.
     *
     * @param requests    List of session requests (each with member name, start time, end time)
     * @param numTrainers Number of personal trainers available on duty (1 to 5)
     * @return A {@link ScheduleResult} detailing assignments, rejected sessions, and execution trace
     */
    public static ScheduleResult schedule(ArrayList<TrainerSession> requests, int numTrainers) {
        ArrayList<String> steps = new ArrayList<>();
        ArrayList<TrainerSession> scheduledSessions = new ArrayList<>();
        ArrayList<TrainerSession> unscheduledSessions = new ArrayList<>();
        HashMap<String, ArrayList<TrainerSession>> trainerAssignments = new HashMap<>();

        int totalRequested = (requests != null) ? requests.size() : 0;

        if (requests == null || requests.isEmpty()) {
            steps.add("No session requests submitted. Scheduling completed with 0 assignments.");
            return new ScheduleResult(scheduledSessions, unscheduledSessions, steps, 0, 0, trainerAssignments);
        }

        // Determine active trainers
        int trainerCount = Math.max(1, Math.min(numTrainers, DEFAULT_TRAINERS.length));
        String[] activeTrainers = new String[trainerCount];
        int[] lastBusyUntil = new int[trainerCount]; // minutes from midnight

        for (int i = 0; i < trainerCount; i++) {
            activeTrainers[i] = DEFAULT_TRAINERS[i];
            lastBusyUntil[i] = 0;
            trainerAssignments.put(activeTrainers[i], new ArrayList<>());
        }

        steps.add(String.format("Initializing Greedy Scheduler with %d trainers: %s",
                trainerCount, String.join(", ", activeTrainers)));

        // 1. Sort sessions by end time from scratch (Merge Sort)
        ArrayList<TrainerSession> sortedRequests = scratchSortByEndTime(requests);
        steps.add("Sort sessions by end time: " + sortedRequests.size() + " requests ordered by earliest finish time.");

        // 2. Greedily assign sessions
        for (TrainerSession session : sortedRequests) {
            String sessionDesc = String.format("[%s, %s-%s]",
                    session.getMemberName(),
                    TrainerSession.formatTime(session.getStartTime()),
                    TrainerSession.formatTime(session.getEndTime()));

            int assignedTrainerIdx = -1;
            StringBuilder busyNote = new StringBuilder();

            for (int t = 0; t < trainerCount; t++) {
                if (lastBusyUntil[t] <= session.getStartTime()) {
                    assignedTrainerIdx = t;
                    break;
                } else {
                    if (busyNote.length() > 0) {
                        busyNote.append(", ");
                    }
                    busyNote.append(activeTrainers[t])
                            .append(" busy until ")
                            .append(TrainerSession.formatTime(lastBusyUntil[t]));
                }
            }

            if (assignedTrainerIdx != -1) {
                String trainer = activeTrainers[assignedTrainerIdx];
                session.setTrainerName(trainer);
                lastBusyUntil[assignedTrainerIdx] = session.getEndTime();

                scheduledSessions.add(session);
                trainerAssignments.get(trainer).add(session);

                if (assignedTrainerIdx == 0) {
                    steps.add("Assign " + sessionDesc + " to Trainer " + trainer);
                } else {
                    steps.add("Assign " + sessionDesc + " to Trainer " + trainer + " (" + busyNote.toString() + ")");
                }
            } else {
                unscheduledSessions.add(session);
                steps.add("Skip " + sessionDesc + " — all trainers busy");
            }
        }

        steps.add(String.format("Scheduling summary: %d assigned, %d unscheduled out of %d requests.",
                scheduledSessions.size(), unscheduledSessions.size(), totalRequested));

        return new ScheduleResult(
                scheduledSessions,
                unscheduledSessions,
                steps,
                scheduledSessions.size(),
                totalRequested,
                trainerAssignments
        );
    }

    /**
     * Custom scratch merge sort for ordering TrainerSession objects by endTime in non-decreasing order.
     * Does not utilize Arrays.sort or Collections.sort.
     *
     * @param input List of sessions to sort
     * @return New ArrayList containing sessions sorted by endTime
     */
    private static ArrayList<TrainerSession> scratchSortByEndTime(ArrayList<TrainerSession> input) {
        if (input == null || input.size() <= 1) {
            return new ArrayList<>(input != null ? input : new ArrayList<>());
        }

        TrainerSession[] array = input.toArray(new TrainerSession[0]);
        mergeSortSessions(array, 0, array.length - 1);

        ArrayList<TrainerSession> sortedList = new ArrayList<>(array.length);
        for (TrainerSession s : array) {
            // Create a fresh copy to avoid altering caller state
            sortedList.add(new TrainerSession(s.getMemberName(), s.getTrainerName(), s.getStartTime(), s.getEndTime()));
        }
        return sortedList;
    }

    private static void mergeSortSessions(TrainerSession[] arr, int left, int right) {
        if (left < right) {
            int mid = left + (right - left) / 2;
            mergeSortSessions(arr, left, mid);
            mergeSortSessions(arr, mid + 1, right);
            mergeSessions(arr, left, mid, right);
        }
    }

    private static void mergeSessions(TrainerSession[] arr, int left, int mid, int right) {
        int n1 = mid - left + 1;
        int n2 = right - mid;

        TrainerSession[] L = new TrainerSession[n1];
        TrainerSession[] R = new TrainerSession[n2];

        for (int i = 0; i < n1; i++) {
            L[i] = arr[left + i];
        }
        for (int j = 0; j < n2; j++) {
            R[j] = arr[mid + 1 + j];
        }

        int i = 0, j = 0, k = left;

        while (i < n1 && j < n2) {
            // Sort primarily by endTime; if equal, break tie by startTime
            if (L[i].getEndTime() < R[j].getEndTime()
                    || (L[i].getEndTime() == R[j].getEndTime() && L[i].getStartTime() <= R[j].getStartTime())) {
                arr[k++] = L[i++];
            } else {
                arr[k++] = R[j++];
            }
        }

        while (i < n1) {
            arr[k++] = L[i++];
        }
        while (j < n2) {
            arr[k++] = R[j++];
        }
    }
}
