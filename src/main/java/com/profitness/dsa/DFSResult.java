package com.profitness.dsa;

import java.util.ArrayList;

/**
 * Result container for Depth-First Search (DFS) graph traversal.
 * <p>
 * Encapsulates the sequential node visit order alongside a detailed diagnostic step log
 * illustrating the recursive / backtrack exploration path for front-end visualization.
 * </p>
 */
public class DFSResult {
    private ArrayList<String> visitOrder;
    private ArrayList<String> steps;

    /**
     * Constructs a DFSResult with visit sequence and step-by-step trace.
     *
     * @param visitOrder list of graph zone names in the order visited by DFS
     * @param steps      chronological trace of recursive steps (visit, branch, backtrack, skip)
     */
    public DFSResult(ArrayList<String> visitOrder, ArrayList<String> steps) {
        this.visitOrder = visitOrder;
        this.steps = steps;
    }

    public ArrayList<String> getVisitOrder() {
        return visitOrder;
    }

    public void setVisitOrder(ArrayList<String> visitOrder) {
        this.visitOrder = visitOrder;
    }

    public ArrayList<String> getSteps() {
        return steps;
    }

    public void setSteps(ArrayList<String> steps) {
        this.steps = steps;
    }

    @Override
    public String toString() {
        return "DFSResult{" +
                "visitOrder=" + visitOrder +
                ", stepsCount=" + (steps != null ? steps.size() : 0) +
                '}';
    }
}
