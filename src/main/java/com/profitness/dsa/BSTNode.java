package com.profitness.dsa;

/**
 * Node for the Member Binary Search Tree (BST).
 * <p>
 * <b>Data Structure:</b> Binary Search Tree Node<br>
 * <b>Pointers:</b> Contains {@code left} (for smaller member IDs) and {@code right} (for larger member IDs) pointers.<br>
 * <b>Time Complexity:</b> O(1) for node allocation and pointer manipulation.<br>
 * <b>Gym Application:</b> Stores indexed member credentials keyed by unique member ID to facilitate
 * logarithmic time lookups at the front reception desk.
 * </p>
 */
public class BSTNode {
    public int memberID;
    public String memberName;
    public BSTNode left;
    public BSTNode right;

    /**
     * Constructs a leaf BSTNode with no child pointers.
     *
     * @param memberID   Numerical ID used as the search key in the BST
     * @param memberName Member's full name
     */
    public BSTNode(int memberID, String memberName) {
        this.memberID = memberID;
        this.memberName = memberName;
        this.left = null;
        this.right = null;
    }

    /**
     * Constructs a BSTNode with explicit left and right child pointers.
     *
     * @param memberID   Numerical key ID
     * @param memberName Member's full name
     * @param left       Left child node (contains keys &lt; memberID)
     * @param right      Right child node (contains keys &gt; memberID)
     */
    public BSTNode(int memberID, String memberName, BSTNode left, BSTNode right) {
        this.memberID = memberID;
        this.memberName = memberName;
        this.left = left;
        this.right = right;
    }

    // Getters and Setters for JSP Bean and OOP encapsulation

    public int getMemberID() {
        return memberID;
    }

    public void setMemberID(int memberID) {
        this.memberID = memberID;
    }

    public String getMemberName() {
        return memberName;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }

    public BSTNode getLeft() {
        return left;
    }

    public void setLeft(BSTNode left) {
        this.left = left;
    }

    public BSTNode getRight() {
        return right;
    }

    public void setRight(BSTNode right) {
        this.right = right;
    }

    /**
     * Checks if this BST node is a leaf (no left or right children).
     *
     * @return true if both child pointers are null
     */
    public boolean isLeaf() {
        return left == null && right == null;
    }

    @Override
    public String toString() {
        return "BSTNode[ID: " + memberID + ", Name: " + memberName + "]";
    }
}
