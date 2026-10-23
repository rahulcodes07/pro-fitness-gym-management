package com.profitness.dsa;

import java.util.ArrayList;

/**
 * Encapsulates the results of the 0/1 Knapsack Dynamic Programming Workout Planner.
 * <p>
 * <b>Data Structure & Algorithmic Role:</b><br>
 * Transports the optimal subset of selected exercises, total fitness score achieved,
 * total time expended, user-specified time budget, 2D dynamic programming memoization table,
 * and step-by-step trace logs.
 * </p>
 * <p>
 * <b>Time Complexity:</b><br>
 * O(1) for accessor methods and metric evaluation.
 * </p>
 * <p>
 * <b>Gym Application:</b><br>
 * Transferred to the web frontend to render the visual DP matrix, show the selected exercises,
 * and display the mathematical decisions made at each cell.
 * </p>
 */
public class KnapsackResult {
    private final ArrayList<WorkoutExercise> selectedExercises;
    private final int totalFitnessValue;
    private final int totalTimeCost;
    private final int timeLimit;
    private final ArrayList<String> steps;
    private final int[][] dpTable;

    /**
     * Constructs a comprehensive KnapsackResult.
     *
     * @param selectedExercises Subset of exercises selected for optimal total fitness value
     * @param totalFitnessValue Total accumulated fitness score
     * @param totalTimeCost     Total minutes required for selected exercises
     * @param timeLimit         Original available time budget
     * @param steps             Step-by-step log of DP table construction and backtracking
     * @param dpTable           Full 2D DP matrix of size (N+1) x (W+1)
     */
    public KnapsackResult(ArrayList<WorkoutExercise> selectedExercises,
                          int totalFitnessValue,
                          int totalTimeCost,
                          int timeLimit,
                          ArrayList<String> steps,
                          int[][] dpTable) {
        this.selectedExercises = selectedExercises != null ? selectedExercises : new ArrayList<>();
        this.totalFitnessValue = totalFitnessValue;
        this.totalTimeCost = totalTimeCost;
        this.timeLimit = timeLimit;
        this.steps = steps != null ? steps : new ArrayList<>();
        this.dpTable = dpTable;
    }

    public ArrayList<WorkoutExercise> getSelectedExercises() {
        return selectedExercises;
    }

    public int getTotalFitnessValue() {
        return totalFitnessValue;
    }

    public int getTotalTimeCost() {
        return totalTimeCost;
    }

    public int getTimeLimit() {
        return timeLimit;
    }

    public ArrayList<String> getSteps() {
        return steps;
    }

    public int[][] getDpTable() {
        return dpTable;
    }

    /**
     * @return the remaining unused time within the budget
     */
    public int getRemainingTime() {
        return Math.max(0, timeLimit - totalTimeCost);
    }

    @Override
    public String toString() {
        return String.format("Optimal Workout: %d exercises | Total Value: %d | Time: %d/%d mins",
                selectedExercises.size(), totalFitnessValue, totalTimeCost, timeLimit);
    }
}
