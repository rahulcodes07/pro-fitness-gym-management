package com.profitness.dsa;

import java.util.ArrayList;

/**
 * Provides custom sorting algorithms implemented entirely from scratch
 * for organizing gym member arrays by their primary {@code memberID}.
 * <p>
 * <b>Algorithms Implemented:</b>
 * <ul>
 *   <li><b>Insertion Sort:</b> In-place comparison sort that builds the final sorted array
 *       one item at a time. Ideal for small arrays or nearly sorted data.
 *       Time Complexity: Best O(N), Average O(N²), Worst O(N²). Space Complexity: O(1) auxiliary.</li>
 *   <li><b>Merge Sort:</b> Divide-and-conquer recursive sort that splits the array into halves,
 *       sorts each half recursively, and merges them back together.
 *       Time Complexity: O(N log N) in all cases. Space Complexity: O(N) auxiliary.</li>
 * </ul>
 * </p>
 * <p>
 * <b>Gym Application:</b><br>
 * Allows gym staff to reorder member rosters by member ID before running binary search,
 * generating sequential membership audit reports, or printing ID card batches.
 * </p>
 */
public class SortAlgorithms {

    /**
     * Private constructor to prevent instantiation of utility class.
     */
    private SortAlgorithms() {
    }

    /**
     * Sorts an array of {@link MemberNode} records by {@code memberID} using Insertion Sort.
     * Operates on a defensive copy so original caller references remain untouched.
     *
     * @param members The array of member nodes to sort
     * @return A {@link SortResult} containing the sorted array, comparison count, swap count,
     *         step-by-step diagnostic trace, and wall-clock execution time.
     */
    public static SortResult insertionSort(MemberNode[] members) {
        long startTime = System.nanoTime();
        if (members == null || members.length == 0) {
            ArrayList<String> emptySteps = new ArrayList<>();
            emptySteps.add("Empty or null array provided. No sorting required.");
            return new SortResult("Insertion Sort", new MemberNode[0], 0, 0, emptySteps, System.nanoTime() - startTime);
        }

        // Defensive clone to avoid side effects on caller
        MemberNode[] arr = new MemberNode[members.length];
        for (int idx = 0; idx < members.length; idx++) {
            arr[idx] = members[idx];
        }

        SortResult result = new SortResult("Insertion Sort", arr);
        result.addStep("Starting Insertion Sort on " + arr.length + " members: " + formatIdArray(arr, 0, arr.length - 1));

        for (int i = 1; i < arr.length; i++) {
            MemberNode key = arr[i];
            int j = i - 1;
            boolean moved = false;

            while (j >= 0) {
                result.incrementComparisons();
                if (arr[j] != null && key != null && arr[j].getMemberID() > key.getMemberID()) {
                    arr[j + 1] = arr[j];
                    result.incrementSwapsOrMerges();
                    moved = true;
                    j--;
                } else {
                    break;
                }
            }
            arr[j + 1] = key;

            int keyId = (key != null) ? key.getMemberID() : -1;
            String keyName = (key != null) ? key.getName() : "null";

            if (moved) {
                result.addStep("Pass " + i + ": Insert ID " + keyId + " (" + keyName + ") at position " + (j + 1));
            } else {
                result.addStep("Pass " + i + ": ID " + keyId + " (" + keyName + ") already in place at position " + (j + 1));
            }
        }

        result.addStep("Insertion Sort complete: " + formatIdArray(arr, 0, arr.length - 1));
        result.setTimeNanos(System.nanoTime() - startTime);
        return result;
    }

    /**
     * Sorts an array of {@link MemberNode} records by {@code memberID} using Merge Sort.
     * Implemented using a divide-and-conquer strategy without standard library sort utilities.
     *
     * @param members The array of member nodes to sort
     * @return A {@link SortResult} containing the sorted array, comparison count, merge count,
     *         step-by-step diagnostic trace, and wall-clock execution time.
     */
    public static SortResult mergeSort(MemberNode[] members) {
        long startTime = System.nanoTime();
        if (members == null || members.length == 0) {
            ArrayList<String> emptySteps = new ArrayList<>();
            emptySteps.add("Empty or null array provided. No sorting required.");
            return new SortResult("Merge Sort", new MemberNode[0], 0, 0, emptySteps, System.nanoTime() - startTime);
        }

        // Defensive copy
        MemberNode[] arr = new MemberNode[members.length];
        for (int idx = 0; idx < members.length; idx++) {
            arr[idx] = members[idx];
        }

        SortResult result = new SortResult("Merge Sort", arr);
        result.addStep("Starting Merge Sort on " + arr.length + " members: " + formatIdArray(arr, 0, arr.length - 1));

        mergeSortHelper(arr, 0, arr.length - 1, result);

        result.addStep("Merge Sort complete: " + formatIdArray(arr, 0, arr.length - 1));
        result.setTimeNanos(System.nanoTime() - startTime);
        return result;
    }

    /**
     * Recursive divide-and-conquer helper method for Merge Sort.
     *
     * @param arr    The working array of member nodes
     * @param left   Starting index of the sub-array
     * @param right  Ending index of the sub-array
     * @param result Diagnostic collector for tracking comparisons, merges, and steps
     */
    public static void mergeSortHelper(MemberNode[] arr, int left, int right, SortResult result) {
        if (left < right) {
            int mid = left + (right - left) / 2;

            result.addStep("Divide: " + formatIdArray(arr, left, right)
                    + " -> " + formatIdArray(arr, left, mid)
                    + " and " + formatIdArray(arr, mid + 1, right));

            mergeSortHelper(arr, left, mid, result);
            mergeSortHelper(arr, mid + 1, right, result);

            merge(arr, left, mid, right, result);
        }
    }

    /**
     * Merges two sorted contiguous sub-arrays [left..mid] and [mid+1..right]
     * into a single sorted range.
     *
     * @param arr    The working array containing both sorted segments
     * @param left   Start index of left partition
     * @param mid    End index of left partition
     * @param right  End index of right partition
     * @param result Diagnostic collector for tracking comparisons, merges, and steps
     */
    public static void merge(MemberNode[] arr, int left, int mid, int right, SortResult result) {
        int n1 = mid - left + 1;
        int n2 = right - mid;

        MemberNode[] leftArr = new MemberNode[n1];
        MemberNode[] rightArr = new MemberNode[n2];

        for (int i = 0; i < n1; i++) {
            leftArr[i] = arr[left + i];
        }
        for (int j = 0; j < n2; j++) {
            rightArr[j] = arr[mid + 1 + j];
        }

        String leftSummary = formatIdArray(leftArr, 0, n1 - 1);
        String rightSummary = formatIdArray(rightArr, 0, n2 - 1);

        int i = 0, j = 0, k = left;

        while (i < n1 && j < n2) {
            result.incrementComparisons();
            int id1 = leftArr[i] != null ? leftArr[i].getMemberID() : Integer.MAX_VALUE;
            int id2 = rightArr[j] != null ? rightArr[j].getMemberID() : Integer.MAX_VALUE;

            if (id1 <= id2) {
                arr[k] = leftArr[i];
                i++;
            } else {
                arr[k] = rightArr[j];
                j++;
            }
            result.incrementSwapsOrMerges();
            k++;
        }

        while (i < n1) {
            arr[k] = leftArr[i];
            result.incrementSwapsOrMerges();
            i++;
            k++;
        }

        while (j < n2) {
            arr[k] = rightArr[j];
            result.incrementSwapsOrMerges();
            j++;
            k++;
        }

        result.addStep("Merge: " + leftSummary + " + " + rightSummary + " -> " + formatIdArray(arr, left, right));
    }

    /**
     * Formats an array slice as a readable list of IDs (e.g. "[1, 3, 5, 8]").
     *
     * @param arr   The array of MemberNodes
     * @param start Starting index
     * @param end   Ending index
     * @return Formatted string representation
     */
    private static String formatIdArray(MemberNode[] arr, int start, int end) {
        if (arr == null || start > end || start < 0 || end >= arr.length) {
            return "[]";
        }
        StringBuilder sb = new StringBuilder("[");
        for (int i = start; i <= end; i++) {
            if (arr[i] != null) {
                sb.append(arr[i].getMemberID());
            } else {
                sb.append("null");
            }
            if (i < end) {
                sb.append(", ");
            }
        }
        sb.append("]");
        return sb.toString();
    }
}
