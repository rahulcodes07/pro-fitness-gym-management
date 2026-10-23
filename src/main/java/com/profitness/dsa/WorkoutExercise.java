package com.profitness.dsa;

/**
 * Represents a single workout exercise with an associated time commitment
 * and estimated fitness value (effectiveness/calorie impact score).
 * <p>
 * <b>Data Structure & Domain Entity:</b><br>
 * Represents an individual item in the 0/1 Knapsack dynamic programming formulation,
 * where {@code timeCost} corresponds to the item weight and {@code fitnessValue}
 * corresponds to the item profit/value.
 * </p>
 * <p>
 * <b>Time Complexity:</b><br>
 * O(1) for all field accessors and mutators.
 * </p>
 * <p>
 * <b>Gym Application:</b><br>
 * Gym members frequently have strict time constraints (e.g. a 45-minute lunch break).
 * This entity allows formulating a workout session that maximizes training results within
 * that fixed time window.
 * </p>
 */
public class WorkoutExercise {
    private String name;
    private int timeCost;      // Time required in minutes (weight)
    private int fitnessValue;  // Value/benefit score, e.g. 1-10 (profit)

    /**
     * Constructs a WorkoutExercise instance.
     *
     * @param name         Name of the exercise (e.g., "Bench Press", "HIIT Sprint", "Plank")
     * @param timeCost     Duration needed in minutes (must be > 0)
     * @param fitnessValue Subjective value/intensity rating (typically 1 to 10)
     */
    public WorkoutExercise(String name, int timeCost, int fitnessValue) {
        this.name = name;
        this.timeCost = Math.max(1, timeCost);
        this.fitnessValue = Math.max(0, fitnessValue);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getTimeCost() {
        return timeCost;
    }

    public void setTimeCost(int timeCost) {
        this.timeCost = Math.max(1, timeCost);
    }

    public int getFitnessValue() {
        return fitnessValue;
    }

    public void setFitnessValue(int fitnessValue) {
        this.fitnessValue = Math.max(0, fitnessValue);
    }

    @Override
    public String toString() {
        return String.format("%s (%d mins, Value: %d)", name, timeCost, fitnessValue);
    }
}
