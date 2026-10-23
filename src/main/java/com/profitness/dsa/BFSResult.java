package com.profitness.dsa;

import java.util.ArrayList;

/**
 * Result container for Breadth-First Search (BFS) graph traversal.
 * <p>
 * Encapsulates the sequential node visit order alongside a detailed diagnostic step log
 * illustrating the queue-based expansion for front-end visualization.
 * </p>
 */
public class BFSResult {
    private ArrayList<String> visitOrder;
    private ArrayList<String> steps;

    /**
     * Constructs a BFSResult with visit sequence and step-by-step trace.
     *
     * @param visitOrder list of graph zone names in the order visited by BFS
     * @param steps      chronological trace of queue operations (enqueue, dequeue, skip)
     */
    public BFSResult(ArrayList<String> visitOrder, ArrayList<String> steps) {
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
        return "BFSResult{" +
                "visitOrder=" + visitOrder +
                ", stepsCount=" + (steps != null ? steps.size() : 0) +
                '}';
    }
}
