package com.profitness.dsa;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * Encapsulates the results of the Greedy Trainer Activity Selection Scheduler.
 * <p>
 * <b>Data Structure & Algorithmic Role:</b><br>
 * Transports the list of successfully scheduled sessions, unscheduled (rejected/overflow)
 * session requests, trainer-specific timetable breakdown, metrics, and execution steps.
 * </p>
 * <p>
 * <b>Time Complexity:</b><br>
 * O(1) for field accessors and summary retrievals.
 * </p>
 * <p>
 * <b>Gym Application:</b><br>
 * Gives the gym manager a complete overview of daily trainer schedules, identifying peak
 * period bottlenecks and showing which members secured their training slots.
 * </p>
 */
public class ScheduleResult {
    private final ArrayList<TrainerSession> scheduledSessions;
    private final ArrayList<TrainerSession> unscheduledSessions;
    private final ArrayList<String> steps;
    private final int totalSessionsScheduled;
    private final int totalSessionsRequested;
    private final HashMap<String, ArrayList<TrainerSession>> trainerAssignments;

    /**
     * Constructs a comprehensive ScheduleResult record.
     *
     * @param scheduledSessions      List of sessions successfully assigned to trainers
     * @param unscheduledSessions    List of sessions that conflicted and could not be accommodated
     * @param steps                  Trace log detailing scheduling decisions
     * @param totalSessionsScheduled Total count of accommodated sessions
     * @param totalSessionsRequested Total count of submitted session requests
     * @param trainerAssignments    Map of trainer name to their ordered list of assigned sessions
     */
    public ScheduleResult(ArrayList<TrainerSession> scheduledSessions,
                          ArrayList<TrainerSession> unscheduledSessions,
                          ArrayList<String> steps,
                          int totalSessionsScheduled,
                          int totalSessionsRequested,
                          HashMap<String, ArrayList<TrainerSession>> trainerAssignments) {
        this.scheduledSessions = scheduledSessions != null ? scheduledSessions : new ArrayList<>();
        this.unscheduledSessions = unscheduledSessions != null ? unscheduledSessions : new ArrayList<>();
        this.steps = steps != null ? steps : new ArrayList<>();
        this.totalSessionsScheduled = totalSessionsScheduled;
        this.totalSessionsRequested = totalSessionsRequested;
        this.trainerAssignments = trainerAssignments != null ? trainerAssignments : new HashMap<>();
    }

    public ArrayList<TrainerSession> getScheduledSessions() {
        return scheduledSessions;
    }

    public ArrayList<TrainerSession> getUnscheduledSessions() {
        return unscheduledSessions;
    }

    public ArrayList<String> getSteps() {
        return steps;
    }

    public int getTotalSessionsScheduled() {
        return totalSessionsScheduled;
    }

    public int getTotalSessionsRequested() {
        return totalSessionsRequested;
    }

    public HashMap<String, ArrayList<TrainerSession>> getTrainerAssignments() {
        return trainerAssignments;
    }

    /**
     * Convenience method returning sessions assigned to a specific trainer.
     *
     * @param trainerName Name of the trainer
     * @return List of assigned sessions or empty list if none
     */
    public ArrayList<TrainerSession> getSessionsForTrainer(String trainerName) {
        return trainerAssignments.getOrDefault(trainerName, new ArrayList<>());
    }

    @Override
    public String toString() {
        return String.format("Scheduled: %d/%d sessions (%.1f%%) across %d trainers",
                totalSessionsScheduled, totalSessionsRequested,
                (totalSessionsRequested > 0 ? (totalSessionsScheduled * 100.0 / totalSessionsRequested) : 0.0),
                trainerAssignments.size());
    }
}
