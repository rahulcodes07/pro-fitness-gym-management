package com.profitness.dsa;

import java.util.ArrayList;

/**
 * Solves the 0/1 Knapsack problem using Dynamic Programming to determine the
 * optimal combination of workout exercises that maximize fitness value
 * within a member's constrained workout time limit.
 * <p>
 * <b>Algorithm:</b><br>
 * Utilizes a 2D Dynamic Programming table {@code dp[i][w]} where:
 * <ul>
 *   <li>{@code i} represents the first {@code i} exercises considered.</li>
 *   <li>{@code w} represents the current workout time budget in minutes.</li>
 *   <li>{@code dp[i][w] = max(dp[i-1][w], dp[i-1][w - timeCost_i] + fitnessValue_i)} if timeCost_i &le; w.</li>
 * </ul>
 * After populating the table, it backtracks from {@code dp[N][W]} to identify the exact exercises chosen.
 * </p>
 * <p>
 * <b>Time Complexity:</b><br>
 * O(N * W) where N is the number of exercises and W is the total time limit in minutes.<br>
 * Space Complexity: O(N * W) for the 2D DP memoization table.
 * </p>
 * <p>
 * <b>Gym Application:</b><br>
 * When a member only has 30 or 45 minutes to exercise, this algorithm selects
 * the highest-impact combination of exercises (cardio, strength, flexibility, core)
 * to maximize caloric burn and muscle activation without exceeding their time limit.
 * </p>
 */
public class KnapsackSolver {

    /**
     * Private constructor to prevent instantiation of utility class.
     */
    private KnapsackSolver() {
    }

    /**
     * Solves the 0/1 Knapsack optimization problem for the provided exercises and time limit.
     *
     * @param exercises      List of available candidate workout exercises
     * @param totalTimeLimit Maximum allowable session duration in minutes
     * @return A {@link KnapsackResult} containing the selected exercises, optimal fitness value,
     *         total time required, DP table, and execution trace.
     */
    public static KnapsackResult solve(ArrayList<WorkoutExercise> exercises, int totalTimeLimit) {
        ArrayList<String> steps = new ArrayList<>();

        if (exercises == null || exercises.isEmpty() || totalTimeLimit <= 0) {
            steps.add("Invalid or empty input provided: exercises count="
                    + (exercises == null ? 0 : exercises.size()) + ", timeLimit=" + totalTimeLimit);
            int[][] emptyTable = new int[1][1];
            return new KnapsackResult(new ArrayList<>(), 0, 0, Math.max(0, totalTimeLimit), steps, emptyTable);
        }

        int n = exercises.size();
        int W = totalTimeLimit;
        int[][] dp = new int[n + 1][W + 1];

        steps.add(String.format("Starting 0/1 Knapsack Workout Optimization: %d exercises available, total time limit = %d minutes.", n, W));
        steps.add(String.format("Building DP table of size [%d x %d]...", n + 1, W + 1));

        // 1. Build DP Table
        for (int i = 1; i <= n; i++) {
            WorkoutExercise ex = exercises.get(i - 1);
            int wi = ex.getTimeCost();
            int vi = ex.getFitnessValue();

            steps.add(String.format("Consider %s (time=%d, value=%d): Include? dp[i][w] = max(dp[i-1][w], dp[i-1][w-%d] + %d)",
                    ex.getName(), wi, vi, wi, vi));

            for (int w = 0; w <= W; w++) {
                if (wi <= w) {
                    dp[i][w] = Math.max(dp[i - 1][w], dp[i - 1][w - wi] + vi);
                } else {
                    dp[i][w] = dp[i - 1][w];
                }
            }
        }

        // 2. Backtrack to find selected exercises
        steps.add(String.format("Backtracking from dp[%d][%d] = %d to determine optimal exercise selection...",
                n, W, dp[n][W]));

        ArrayList<WorkoutExercise> selected = new ArrayList<>();
        int currW = W;

        for (int i = n; i > 0 && currW > 0; i--) {
            WorkoutExercise ex = exercises.get(i - 1);
            // If value differs from the cell above, the item was included
            if (dp[i][currW] != dp[i - 1][currW]) {
                selected.add(ex);
                int prevW = currW;
                currW -= ex.getTimeCost();
                steps.add(String.format("-> Selected: %s (Time: %dm, Value: %d). Capacity: %dm -> %dm.",
                        ex.getName(), ex.getTimeCost(), ex.getFitnessValue(), prevW, currW));
            } else {
                steps.add(String.format("-> Skipped: %s (Time: %dm, Value: %d) — not in optimal subset.",
                        ex.getName(), ex.getTimeCost(), ex.getFitnessValue()));
            }
        }

        // Calculate total time cost
        int totalTimeCost = 0;
        for (WorkoutExercise item : selected) {
            totalTimeCost += item.getTimeCost();
        }

        int totalFitnessValue = dp[n][W];
        steps.add(String.format("Optimization Complete: Selected %d exercises with total fitness value %d using %d/%d minutes.",
                selected.size(), totalFitnessValue, totalTimeCost, totalTimeLimit));

        return new KnapsackResult(selected, totalFitnessValue, totalTimeCost, totalTimeLimit, steps, dp);
    }
}
