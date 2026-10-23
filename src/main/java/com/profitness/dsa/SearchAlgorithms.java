package com.profitness.dsa;

import java.util.ArrayList;

/**
 * Provides search algorithms implemented from scratch for querying gym member records.
 * <p>
 * <b>Algorithms Implemented:</b>
 * <ul>
 *   <li><b>Linear Search:</b> Sequentially evaluates each record from index 0 to N-1.
 *       Time Complexity: O(1) best case, O(N) average and worst case. Space Complexity: O(1) auxiliary.</li>
 *   <li><b>Binary Search:</b> Iteratively divides a sorted array in half using low, mid, and high pointers.
 *       Time Complexity: O(1) best case, O(log N) average and worst case. Space Complexity: O(1) auxiliary.</li>
 * </ul>
 * </p>
 * <p>
 * <b>Gym Application:</b><br>
 * When a front desk receptionist types a Member ID into the check-in or billing terminal,
 * these algorithms locate the member record. Binary search offers near-instant lookups
 * even when the gym database grows to thousands of active gym subscriptions.
 * </p>
 */
public class SearchAlgorithms {

    /**
     * Private constructor to prevent instantiation of utility class.
     */
    private SearchAlgorithms() {
    }

    /**
     * Performs a sequential linear search across an array of {@link MemberNode} objects.
     * Records every step and comparison for educational visualization.
     *
     * @param members  Array of member nodes (does not need to be sorted)
     * @param targetID The numerical member ID to locate
     * @return A {@link SearchResult} encapsulating whether the member was found, comparisons count,
     *         step-by-step trace log, and execution time in nanoseconds.
     */
    public static SearchResult linearSearch(MemberNode[] members, int targetID) {
        long startTime = System.nanoTime();
        ArrayList<String> steps = new ArrayList<>();
        int comparisons = 0;

        if (members == null || members.length == 0) {
            steps.add("Search space is empty. Member ID " + targetID + " not found.");
            long duration = System.nanoTime() - startTime;
            return new SearchResult("Linear Search", targetID, null, 0, steps, duration);
        }

        steps.add("Initiating Linear Search for Member ID " + targetID + " across " + members.length + " registered records.");

        for (int i = 0; i < members.length; i++) {
            MemberNode current = members[i];
            comparisons++;

            if (current == null) {
                steps.add(String.format("Index %d: Node is null, skipping.", i));
                continue;
            }

            int currentID = current.getMemberID();
            if (currentID == targetID) {
                steps.add(String.format("Comparing with ID %d (%s)... Match! Found ID %d at index %d!",
                        currentID, current.getName(), targetID, i));
                long duration = System.nanoTime() - startTime;
                return new SearchResult("Linear Search", targetID, current, comparisons, steps, duration);
            } else {
                steps.add(String.format("Comparing with ID %d (%s)... no match (target: %d)",
                        currentID, current.getName(), targetID));
            }
        }

        steps.add(String.format("Exhausted all %d records. Member ID %d was not found.", members.length, targetID));
        long duration = System.nanoTime() - startTime;
        return new SearchResult("Linear Search", targetID, null, comparisons, steps, duration);
    }

    /**
     * Performs an iterative binary search over an array of {@link MemberNode} objects
     * pre-sorted in ascending order by {@code memberID}.
     * Records each halving step and comparison for visualization.
     *
     * @param sortedMembers Array of member nodes pre-sorted by memberID in ascending order
     * @param targetID      The numerical member ID to locate
     * @return A {@link SearchResult} encapsulating whether the member was found, comparisons count,
     *         step-by-step trace log, and execution time in nanoseconds.
     */
    public static SearchResult binarySearch(MemberNode[] sortedMembers, int targetID) {
        long startTime = System.nanoTime();
        ArrayList<String> steps = new ArrayList<>();
        int comparisons = 0;

        if (sortedMembers == null || sortedMembers.length == 0) {
            steps.add("Search space is empty. Member ID " + targetID + " not found.");
            long duration = System.nanoTime() - startTime;
            return new SearchResult("Binary Search", targetID, null, 0, steps, duration);
        }

        steps.add("Initiating Iterative Binary Search for Member ID " + targetID
                + " over sorted array of size " + sortedMembers.length + ".");

        int low = 0;
        int high = sortedMembers.length - 1;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            MemberNode midNode = sortedMembers[mid];
            comparisons++;

            if (midNode == null) {
                steps.add(String.format("low=%d, high=%d, mid=%d -> Encountered null node at mid index.", low, high, mid));
                break;
            }

            int midID = midNode.getMemberID();

            if (midID == targetID) {
                steps.add(String.format("low=%d, high=%d, mid=%d -> Comparing with ID %d (%s)... Match found! Target ID %d located at index %d!",
                        low, high, mid, midID, midNode.getName(), targetID, mid));
                long duration = System.nanoTime() - startTime;
                return new SearchResult("Binary Search", targetID, midNode, comparisons, steps, duration);
            } else if (midID > targetID) {
                steps.add(String.format("low=%d, high=%d, mid=%d -> Comparing with ID %d (%s)... target %d is smaller, go left (high=%d)",
                        low, high, mid, midID, midNode.getName(), targetID, mid - 1));
                high = mid - 1;
            } else {
                steps.add(String.format("low=%d, high=%d, mid=%d -> Comparing with ID %d (%s)... target %d is larger, go right (low=%d)",
                        low, high, mid, midID, midNode.getName(), targetID, mid + 1));
                low = mid + 1;
            }
        }

        steps.add(String.format("Search interval exhausted (low=%d > high=%d). Member ID %d not found in database.", low, high, targetID));
        long duration = System.nanoTime() - startTime;
        return new SearchResult("Binary Search", targetID, null, comparisons, steps, duration);
    }
}
