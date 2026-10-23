package com.profitness.dsa;

import java.util.ArrayList;

/**
 * Encapsulates the complete diagnostic outcome of executing a search algorithm
 * (such as Linear Search or Binary Search) over gym member records.
 * <p>
 * <b>Data Structure & Algorithmic Role:</b><br>
 * Serves as an immutable transfer object containing the matched {@link MemberNode},
 * total comparison count, step-by-step visual execution trace log, elapsed nanoseconds,
 * and algorithm metadata.
 * </p>
 * <p>
 * <b>Time Complexity:</b><br>
 * O(1) for all field accessors and outcome evaluation.
 * </p>
 * <p>
 * <b>Gym Application:</b><br>
 * Enables the administrative interface to visually demonstrate to students and staff
 * the operational difference in performance and traversal depth between an O(N) sequential
 * scan and an O(log N) divide-and-conquer binary search when looking up member IDs.
 * </p>
 */
public class SearchResult {
    private final String algorithmName;
    private final int targetID;
    private final MemberNode found;
    private final int comparisons;
    private final ArrayList<String> steps;
    private final long timeNanos;

    /**
     * Constructs a comprehensive SearchResult record.
     *
     * @param algorithmName Name of the search algorithm applied ("Linear Search" or "Binary Search")
     * @param targetID      The numerical member ID requested
     * @param found         The matching {@link MemberNode}, or {@code null} if no match exists
     * @param comparisons   Total count of primary key comparisons performed
     * @param steps         Detailed chronological trace entries explaining each comparison step
     * @param timeNanos     Wall-clock execution duration measured in nanoseconds
     */
    public SearchResult(String algorithmName, int targetID, MemberNode found,
                        int comparisons, ArrayList<String> steps, long timeNanos) {
        this.algorithmName = algorithmName;
        this.targetID = targetID;
        this.found = found;
        this.comparisons = comparisons;
        this.steps = steps != null ? steps : new ArrayList<>();
        this.timeNanos = timeNanos;
    }

    /**
     * @return the matched MemberNode, or {@code null} if not found
     */
    public MemberNode getFound() {
        return found;
    }

    /**
     * @return {@code true} if a matching member was discovered, {@code false} otherwise
     */
    public boolean isFound() {
        return found != null;
    }

    /**
     * @return the total number of comparisons made during the search
     */
    public int getComparisons() {
        return comparisons;
    }

    /**
     * @return visual list of execution steps recorded during the search
     */
    public ArrayList<String> getSteps() {
        return steps;
    }

    /**
     * @return execution duration in nanoseconds
     */
    public long getTimeNanos() {
        return timeNanos;
    }

    /**
     * @return execution duration converted to fractional milliseconds
     */
    public double getTimeMillis() {
        return timeNanos / 1_000_000.0;
    }

    /**
     * @return the algorithm name used for this search
     */
    public String getAlgorithmName() {
        return algorithmName;
    }

    /**
     * @return the requested member ID target
     */
    public int getTargetID() {
        return targetID;
    }

    @Override
    public String toString() {
        return String.format("[%s] Target ID: %d | Found: %s | Comparisons: %d | Time: %.4f ms",
                algorithmName, targetID, (found != null ? found.getName() : "None"),
                comparisons, getTimeMillis());
    }
}
