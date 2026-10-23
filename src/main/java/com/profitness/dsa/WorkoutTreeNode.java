package com.profitness.dsa;

/**
 * Node structure for the Hierarchical Workout Binary Tree.
 * <p>
 * <b>Data Structure:</b> Binary Tree Node<br>
 * <b>Pointers:</b> Contains {@code left} and {@code right} references pointing to child categories or workout disciplines.<br>
 * <b>Time Complexity:</b> O(1) for node allocation and child pointer updates.<br>
 * <b>Gym Application:</b> Represents a fitness category, domain, or targeted muscle group within a structured
 * workout curriculum (e.g., Cardio, Strength, HIIT, Upper Body, Legs).
 * </p>
 */
public class WorkoutTreeNode {
    public String category;
    public WorkoutTreeNode left;
    public WorkoutTreeNode right;

    /**
     * Constructs a leaf WorkoutTreeNode with no child nodes.
     *
     * @param category the name of the workout category or exercise focus
     */
    public WorkoutTreeNode(String category) {
        this.category = category;
        this.left = null;
        this.right = null;
    }

    /**
     * Constructs a WorkoutTreeNode with specified left and right child nodes.
     *
     * @param category the name of the workout category
     * @param left     the left child node
     * @param right    the right child node
     */
    public WorkoutTreeNode(String category, WorkoutTreeNode left, WorkoutTreeNode right) {
        this.category = category;
        this.left = left;
        this.right = right;
    }

    // Getters and Setters for JSP Bean and OOP encapsulation

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public WorkoutTreeNode getLeft() {
        return left;
    }

    public void setLeft(WorkoutTreeNode left) {
        this.left = left;
    }

    public WorkoutTreeNode getRight() {
        return right;
    }

    public void setRight(WorkoutTreeNode right) {
        this.right = right;
    }

    /**
     * Checks if this node is a leaf (has no children).
     *
     * @return true if both left and right pointers are null
     */
    public boolean isLeaf() {
        return left == null && right == null;
    }

    @Override
    public String toString() {
        return category;
    }
}
