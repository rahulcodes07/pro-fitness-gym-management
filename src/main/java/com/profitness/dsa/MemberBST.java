package com.profitness.dsa;

import java.util.ArrayList;

/**
 * Binary Search Tree (BST) for efficient, indexed gym member lookups.
 * <p>
 * <b>Data Structure:</b> Binary Search Tree using custom {@link BSTNode} references.<br>
 * <b>Ordering Property:</b> For any node {@code N}, all IDs in {@code N.left} &lt; {@code N.memberID},
 * and all IDs in {@code N.right} &gt; {@code N.memberID}.<br>
 * <b>Time Complexities:</b>
 * <ul>
 *   <li>Search (search): Average O(log n), Worst-case O(n) if unbalanced.</li>
 *   <li>Insertion (insert): Average O(log n), Worst-case O(n).</li>
 *   <li>Deletion (delete): Average O(log n), Worst-case O(n).</li>
 *   <li>In-order Traversal (inorderTraversal): O(n) visits all nodes in ascending key order.</li>
 *   <li>Bulk Construction (buildFromMemberList): O(n log n) average.</li>
 * </ul>
 * <b>Gym Application:</b> Provides fast O(log n) member check-ins and identity verifications at the front desk,
 * vastly outperforming linear scans on large membership databases.
 * </p>
 */
public class MemberBST {
    private BSTNode root;
    private int size;
    private boolean wasDeleted;

    /**
     * Initializes an empty MemberBST.
     */
    public MemberBST() {
        this.root = null;
        this.size = 0;
    }

    /**
     * Checks if the tree contains any nodes.
     *
     * @return true if empty, false otherwise
     */
    public boolean isEmpty() {
        return root == null;
    }

    /**
     * Returns the total number of members indexed in this BST.
     *
     * @return member count
     */
    public int getSize() {
        return size;
    }

    /**
     * Retrieves the root node of the BST.
     *
     * @return root BSTNode, or null if empty
     */
    public BSTNode getRoot() {
        return root;
    }

    /**
     * Inserts a member into the Binary Search Tree according to their member ID.
     *
     * @param memberID   Unique member ID (search key)
     * @param memberName Member's full name
     */
    public void insert(int memberID, String memberName) {
        root = insertRecursive(root, memberID, memberName);
    }

    private BSTNode insertRecursive(BSTNode current, int memberID, String memberName) {
        if (current == null) {
            size++;
            return new BSTNode(memberID, memberName);
        }

        if (memberID < current.memberID) {
            current.left = insertRecursive(current.left, memberID, memberName);
        } else if (memberID > current.memberID) {
            current.right = insertRecursive(current.right, memberID, memberName);
        } else {
            // Key already exists; update the member name
            current.memberName = memberName;
        }

        return current;
    }

    /**
     * Searches for a member by their ID while recording the comparison count
     * and step-by-step decision path for educational visualization.
     *
     * @param memberID target ID to locate
     * @return a {@link BSTSearchResult} containing found node, comparison count, and traversal path
     */
    public BSTSearchResult search(int memberID) {
        ArrayList<String> path = new ArrayList<>();
        int comparisons = 0;

        if (root == null) {
            path.add("Search aborted: BST is completely empty.");
            return new BSTSearchResult(null, 0, path);
        }

        BSTNode current = root;
        path.add("Starting BST search for Member ID: " + memberID);

        while (current != null) {
            comparisons++;
            if (memberID == current.memberID) {
                path.add(String.format("Comparison %d: Key %d matches Node [ID: %d, Name: %s] -> Member FOUND!",
                        comparisons, memberID, current.memberID, current.memberName));
                return new BSTSearchResult(current, comparisons, path);
            } else if (memberID < current.memberID) {
                path.add(String.format("Comparison %d: Key %d < Node ID %d (%s) -> Traverse LEFT child",
                        comparisons, memberID, current.memberID, current.memberName));
                current = current.left;
            } else {
                path.add(String.format("Comparison %d: Key %d > Node ID %d (%s) -> Traverse RIGHT child",
                        comparisons, memberID, current.memberID, current.memberName));
                current = current.right;
            }
        }

        path.add(String.format("Search concluded after %d comparisons: Reached null pointer. Member ID %d NOT FOUND in BST.",
                comparisons, memberID));
        return new BSTSearchResult(null, comparisons, path);
    }

    /**
     * Deletes a member node with the specified ID from the BST.
     * Preserves the BST invariant across all deletion cases:
     * 1. Leaf node deletion
     * 2. Single-child node bypass
     * 3. Two-children node replacement via in-order successor (minimum in right subtree)
     *
     * @param memberID the ID of the member to delete
     * @return true if member was present and removed, false if not found
     */
    public boolean delete(int memberID) {
        wasDeleted = false;
        root = deleteRecursive(root, memberID);
        if (wasDeleted) {
            size--;
        }
        return wasDeleted;
    }

    private BSTNode deleteRecursive(BSTNode node, int id) {
        if (node == null) {
            return null;
        }

        if (id < node.memberID) {
            node.left = deleteRecursive(node.left, id);
        } else if (id > node.memberID) {
            node.right = deleteRecursive(node.right, id);
        } else {
            // Match found!
            wasDeleted = true;

            // Case 1: Leaf node (no children)
            if (node.left == null && node.right == null) {
                return null;
            }

            // Case 2: One child (right only)
            if (node.left == null) {
                return node.right;
            }

            // Case 2: One child (left only)
            if (node.right == null) {
                return node.left;
            }

            // Case 3: Two children
            // Find in-order successor (smallest element in right subtree)
            BSTNode successor = findMin(node.right);
            node.memberID = successor.memberID;
            node.memberName = successor.memberName;
            // Delete successor from right subtree
            node.right = deleteRecursive(node.right, successor.memberID);
        }

        return node;
    }

    private BSTNode findMin(BSTNode node) {
        BSTNode current = node;
        while (current.left != null) {
            current = current.left;
        }
        return current;
    }

    /**
     * Performs an In-order traversal of the BST (Left &rarr; Root &rarr; Right).
     * Yields all members in strictly ascending order of their Member ID.
     *
     * @return list of BSTNode objects sorted by member ID
     */
    public ArrayList<BSTNode> inorderTraversal() {
        ArrayList<BSTNode> list = new ArrayList<>(size);
        inorderRecursive(root, list);
        return list;
    }

    private void inorderRecursive(BSTNode node, ArrayList<BSTNode> list) {
        if (node == null) return;
        inorderRecursive(node.left, list);
        list.add(node);
        inorderRecursive(node.right, list);
    }

    /**
     * Bulk inserts all members from a {@link MemberLinkedList} into this BST.
     * Clears existing tree and establishes a newly populated index.
     *
     * @param list the linked list containing member records
     */
    public void buildFromMemberList(MemberLinkedList list) {
        clear();
        if (list == null) return;

        MemberNode current = list.getHead();
        while (current != null) {
            insert(current.memberID, current.name);
            current = current.next;
        }
    }

    /**
     * Clears all nodes from the BST.
     */
    public void clear() {
        this.root = null;
        this.size = 0;
    }
}
