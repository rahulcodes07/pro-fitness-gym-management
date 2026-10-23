package com.profitness.dsa;

import java.util.ArrayList;

/**
 * Encapsulates the outcome, performance metrics, and navigation steps of a BST search query.
 * <p>
 * <b>Data Carrier:</b> Holds the target {@link BSTNode} (or null if absent), the exact number of key
 * comparisons performed, and an ordered list of step-by-step decision strings for visual representation.
 * </p>
 */
public class BSTSearchResult {
    private BSTNode found;
    private int comparisons;
    private ArrayList<String> searchPath;

    /**
     * Constructs a new BSTSearchResult instance.
     *
     * @param found       The {@link BSTNode} matching the searched ID, or null if not found
     * @param comparisons The total number of node comparisons executed during the search
     * @param searchPath  Step-by-step diagnostic log of the traversal path
     */
    public BSTSearchResult(BSTNode found, int comparisons, ArrayList<String> searchPath) {
        this.found = found;
        this.comparisons = comparisons;
        this.searchPath = searchPath;
    }

    /**
     * Indicates whether the search successfully located the member.
     *
     * @return true if member was found in the BST, false otherwise
     */
    public boolean isFound() {
        return found != null;
    }

    public BSTNode getFound() {
        return found;
    }

    public void setFound(BSTNode found) {
        this.found = found;
    }

    public int getComparisons() {
        return comparisons;
    }

    public void setComparisons(int comparisons) {
        this.comparisons = comparisons;
    }

    public ArrayList<String> getSearchPath() {
        return searchPath;
    }

    public void setSearchPath(ArrayList<String> searchPath) {
        this.searchPath = searchPath;
    }

    @Override
    public String toString() {
        return "BSTSearchResult{" +
                "found=" + (found != null ? found.toString() : "null") +
                ", comparisons=" + comparisons +
                ", steps=" + (searchPath != null ? searchPath.size() : 0) +
                '}';
    }
}
