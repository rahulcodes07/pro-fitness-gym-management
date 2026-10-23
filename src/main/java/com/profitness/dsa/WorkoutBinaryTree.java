package com.profitness.dsa;

import java.util.ArrayList;

/**
 * Binary Tree representing the Gym Workout Plan Hierarchy.
 * <p>
 * <b>Data Structure:</b> Binary Tree implemented with custom {@link WorkoutTreeNode} pointers.<br>
 * <b>Pointers:</b> Root pointer to the top-level plan category, each node maintaining {@code left} and {@code right} references.<br>
 * <b>Primary Traversal:</b> <strong>In-order (Left &rarr; Root &rarr; Right)</strong> is used as the
 * main operational traversal for displaying workout categories in a logically sorted order —
 * sub-categories appear before their parent, providing a natural bottom-up curriculum view.<br>
 * Pre-order and Post-order traversals are also implemented for demonstration and comparison purposes
 * to showcase all three classical tree traversal strategies.
 * <b>Time Complexities:</b>
 * <ul>
 *   <li>Inorder Traversal (Primary): O(n) visiting all nodes (Left &rarr; Root &rarr; Right).</li>
 *   <li>Preorder Traversal (Demo): O(n) visiting all nodes (Root &rarr; Left &rarr; Right).</li>
 *   <li>Postorder Traversal (Demo): O(n) visiting all nodes (Left &rarr; Right &rarr; Root).</li>
 *   <li>Tree Building: O(1) fixed predefined hierarchy layout.</li>
 * </ul>
 * <b>Gym Application:</b> Models workout curriculum branching from high-level categories (Workout Plans &rarr; Cardio vs Strength)
 * down to training styles (HIIT, Running) and targeted muscle splits (Upper Body &rarr; Chest, Shoulders; Lower Body &rarr; Legs).
 * </p>
 */
public class WorkoutBinaryTree {
    private WorkoutTreeNode root;

    /**
     * Constructs a WorkoutBinaryTree and automatically populates the default gym curriculum hierarchy.
     */
    public WorkoutBinaryTree() {
        buildDefaultTree();
    }

    /**
     * Builds and attaches the default workout plan hierarchy:
     * <pre>
     *               Workout Plans
     *              /             \
     *         Cardio           Strength
     *         /    \           /        \
     *      HIIT  Running   Upper Body  Lower Body
     *                      /      \        \
     *                   Chest   Shoulders  Legs
     * </pre>
     *
     * @return the root {@link WorkoutTreeNode} of the generated tree
     */
    public WorkoutTreeNode buildDefaultTree() {
        WorkoutTreeNode rootNode = new WorkoutTreeNode("Workout Plans");

        WorkoutTreeNode cardio = new WorkoutTreeNode("Cardio");
        WorkoutTreeNode strength = new WorkoutTreeNode("Strength");
        rootNode.left = cardio;
        rootNode.right = strength;

        cardio.left = new WorkoutTreeNode("HIIT");
        cardio.right = new WorkoutTreeNode("Running");

        WorkoutTreeNode upperBody = new WorkoutTreeNode("Upper Body");
        WorkoutTreeNode lowerBody = new WorkoutTreeNode("Lower Body");
        strength.left = upperBody;
        strength.right = lowerBody;

        upperBody.left = new WorkoutTreeNode("Chest");
        upperBody.right = new WorkoutTreeNode("Shoulders");

        // Lower body right branch contains Legs
        lowerBody.left = new WorkoutTreeNode("Ankles");
        lowerBody.right = new WorkoutTreeNode("Legs");

        this.root = rootNode;
        return rootNode;
    }

    public WorkoutTreeNode getRoot() {
        return root;
    }

    public void setRoot(WorkoutTreeNode root) {
        this.root = root;
    }

    // ==========================================
    // Traversal Lists (Category Names)
    // ==========================================

    /**
     * Performs a Pre-order traversal (Root &rarr; Left &rarr; Right).
     *
     * @return list of category names in pre-order sequence
     */
    public ArrayList<String> preorderTraversal() {
        ArrayList<String> result = new ArrayList<>();
        preorderRecursive(root, result);
        return result;
    }

    private void preorderRecursive(WorkoutTreeNode node, ArrayList<String> result) {
        if (node == null) return;
        result.add(node.category);
        preorderRecursive(node.left, result);
        preorderRecursive(node.right, result);
    }

    /**
     * Performs an In-order traversal (Left &rarr; Root &rarr; Right).
     *
     * @return list of category names in in-order sequence
     */
    public ArrayList<String> inorderTraversal() {
        ArrayList<String> result = new ArrayList<>();
        inorderRecursive(root, result);
        return result;
    }

    private void inorderRecursive(WorkoutTreeNode node, ArrayList<String> result) {
        if (node == null) return;
        inorderRecursive(node.left, result);
        result.add(node.category);
        inorderRecursive(node.right, result);
    }

    /**
     * Performs a Post-order traversal (Left &rarr; Right &rarr; Root).
     *
     * @return list of category names in post-order sequence
     */
    public ArrayList<String> postorderTraversal() {
        ArrayList<String> result = new ArrayList<>();
        postorderRecursive(root, result);
        return result;
    }

    private void postorderRecursive(WorkoutTreeNode node, ArrayList<String> result) {
        if (node == null) return;
        postorderRecursive(node.left, result);
        postorderRecursive(node.right, result);
        result.add(node.category);
    }

    // ==========================================
    // Step-by-Step Traversal Traces for Visualization
    // ==========================================

    /**
     * Generates a step-by-step visual execution path for Pre-order traversal.
     *
     * @return list of navigation actions and visit operations
     */
    public ArrayList<String> preorderSteps() {
        ArrayList<String> steps = new ArrayList<>();
        if (root == null) {
            steps.add("Tree is empty.");
            return steps;
        }
        steps.add("Begin Pre-order Traversal (Order: Root -> Left -> Right)");
        preorderStepsRecursive(root, steps);
        steps.add("Pre-order Traversal Complete.");
        return steps;
    }

    private void preorderStepsRecursive(WorkoutTreeNode node, ArrayList<String> steps) {
        if (node == null) return;

        steps.add("Visit: " + node.category);

        if (node.left != null) {
            steps.add("Go Left from [" + node.category + "] to [" + node.left.category + "]");
            preorderStepsRecursive(node.left, steps);
            steps.add("Return to [" + node.category + "] from left subtree");
        } else {
            steps.add("Left child of [" + node.category + "] is null");
        }

        if (node.right != null) {
            steps.add("Go Right from [" + node.category + "] to [" + node.right.category + "]");
            preorderStepsRecursive(node.right, steps);
            steps.add("Return to [" + node.category + "] from right subtree");
        } else {
            steps.add("Right child of [" + node.category + "] is null");
        }
    }

    /**
     * Generates a step-by-step visual execution path for In-order traversal.
     *
     * @return list of navigation actions and visit operations
     */
    public ArrayList<String> inorderSteps() {
        ArrayList<String> steps = new ArrayList<>();
        if (root == null) {
            steps.add("Tree is empty.");
            return steps;
        }
        steps.add("Begin In-order Traversal (Order: Left -> Root -> Right)");
        inorderStepsRecursive(root, steps);
        steps.add("In-order Traversal Complete.");
        return steps;
    }

    private void inorderStepsRecursive(WorkoutTreeNode node, ArrayList<String> steps) {
        if (node == null) return;

        if (node.left != null) {
            steps.add("Go Left from [" + node.category + "] to [" + node.left.category + "]");
            inorderStepsRecursive(node.left, steps);
            steps.add("Return to [" + node.category + "] from left subtree");
        } else {
            steps.add("Left child of [" + node.category + "] is null");
        }

        steps.add("Visit: " + node.category);

        if (node.right != null) {
            steps.add("Go Right from [" + node.category + "] to [" + node.right.category + "]");
            inorderStepsRecursive(node.right, steps);
            steps.add("Return to [" + node.category + "] from right subtree");
        } else {
            steps.add("Right child of [" + node.category + "] is null");
        }
    }

    /**
     * Generates a step-by-step visual execution path for Post-order traversal.
     *
     * @return list of navigation actions and visit operations
     */
    public ArrayList<String> postorderSteps() {
        ArrayList<String> steps = new ArrayList<>();
        if (root == null) {
            steps.add("Tree is empty.");
            return steps;
        }
        steps.add("Begin Post-order Traversal (Order: Left -> Right -> Root)");
        postorderStepsRecursive(root, steps);
        steps.add("Post-order Traversal Complete.");
        return steps;
    }

    private void postorderStepsRecursive(WorkoutTreeNode node, ArrayList<String> steps) {
        if (node == null) return;

        if (node.left != null) {
            steps.add("Go Left from [" + node.category + "] to [" + node.left.category + "]");
            postorderStepsRecursive(node.left, steps);
            steps.add("Return to [" + node.category + "] from left subtree");
        } else {
            steps.add("Left child of [" + node.category + "] is null");
        }

        if (node.right != null) {
            steps.add("Go Right from [" + node.category + "] to [" + node.right.category + "]");
            postorderStepsRecursive(node.right, steps);
            steps.add("Return to [" + node.category + "] from right subtree");
        } else {
            steps.add("Right child of [" + node.category + "] is null");
        }

        steps.add("Visit: " + node.category);
    }
}
