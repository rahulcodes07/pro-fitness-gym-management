package com.profitness.dsa;

import java.util.ArrayList;

/**
 * Singly Linked List implementation for managing gym members.
 * <p>
 * <b>Data Structure:</b> Custom Singly Linked List with sequential node chaining.<br>
 * <b>Pointers:</b> Maintains a reference to the {@code head} node and tracks the total {@code size}.<br>
 * <b>Time Complexities:</b>
 * <ul>
 *   <li>Insertion (addMember): O(n) due to uniqueness verification, followed by O(1) or O(n) tail attachment.</li>
 *   <li>Search (findMemberById): O(n) linear search from head through chain.</li>
 *   <li>Update (updateMember): O(n) search + O(1) field assignment.</li>
 *   <li>Deletion (removeMemberById): O(n) search + O(1) pointer adjustment.</li>
 *   <li>Conversion to Array (toArray): O(n) linear traversal.</li>
 *   <li>Rebuilding (rebuildFromArray): O(n) pointer relinking.</li>
 * </ul>
 * <b>Gym Application:</b> Serves as the primary in-memory database of registered members. Allows dynamic
 * registration, profile updates, and cancellations without fixed-capacity array constraints.
 * </p>
 */
public class MemberLinkedList {
    private MemberNode head;
    private int size;

    /**
     * Initializes an empty Member Linked List.
     */
    public MemberLinkedList() {
        this.head = null;
        this.size = 0;
    }

    /**
     * Checks if the member list contains any nodes.
     *
     * @return true if the list is empty, false otherwise
     */
    public boolean isEmpty() {
        return head == null;
    }

    /**
     * Returns the current number of registered gym members.
     *
     * @return count of members in the list
     */
    public int getSize() {
        return size;
    }

    /**
     * Retrieves the head pointer of the linked list.
     * Essential for external traversal, searching, and sorting algorithms.
     *
     * @return the head MemberNode, or null if list is empty
     */
    public MemberNode getHead() {
        return head;
    }

    /**
     * Sets the head pointer of the linked list.
     *
     * @param head the new head MemberNode
     */
    public void setHead(MemberNode head) {
        this.head = head;
        // Recalculate size after manual head manipulation
        int count = 0;
        MemberNode curr = head;
        while (curr != null) {
            count++;
            curr = curr.next;
        }
        this.size = count;
    }

    /**
     * Adds a new member to the linked list if the member ID is unique.
     *
     * @param memberID       Unique ID for the member
     * @param name           Full name of the member
     * @param membershipType Membership category (e.g., Monthly, Annual)
     * @param feeStatus      Payment status (e.g., Paid, Pending)
     * @return true if member was successfully added, false if duplicate ID exists
     */
    public boolean addMember(int memberID, String name, String membershipType, String feeStatus) {
        if (findMemberById(memberID) != null) {
            return false;
        }

        MemberNode newNode = new MemberNode(memberID, name, membershipType, feeStatus);

        if (head == null) {
            head = newNode;
        } else {
            MemberNode current = head;
            while (current.next != null) {
                current = current.next;
            }
            current.next = newNode;
        }

        size++;
        return true;
    }

    /**
     * Searches for a member by their unique ID using linear traversal.
     *
     * @param memberID the ID to look for
     * @return the MemberNode if found, null otherwise
     */
    public MemberNode findMemberById(int memberID) {
        MemberNode current = head;
        while (current != null) {
            if (current.memberID == memberID) {
                return current;
            }
            current = current.next;
        }
        return null;
    }

    /**
     * Updates profile details of an existing member.
     *
     * @param memberID          ID of the member to update
     * @param newName           New name value
     * @param newMembershipType New membership type value
     * @param newFeeStatus      New fee status value
     * @return true if updated successfully, false if member was not found
     */
    public boolean updateMember(int memberID, String newName, String newMembershipType, String newFeeStatus) {
        MemberNode member = findMemberById(memberID);
        if (member == null) {
            return false;
        }

        member.name = newName;
        member.membershipType = newMembershipType;
        member.feeStatus = newFeeStatus;
        return true;
    }

    /**
     * Removes a member from the linked list by their unique ID.
     * Reconnects preceding and succeeding pointers to maintain list integrity.
     *
     * @param memberID ID of the member to remove
     * @return true if member was found and removed, false otherwise
     */
    public boolean removeMemberById(int memberID) {
        if (head == null) {
            return false;
        }

        // Case 1: Removing head node
        if (head.memberID == memberID) {
            head = head.next;
            size--;
            return true;
        }

        // Case 2: Removing intermediate or tail node
        MemberNode current = head;
        while (current.next != null && current.next.memberID != memberID) {
            current = current.next;
        }

        if (current.next == null) {
            return false; // Member with ID not found
        }

        current.next = current.next.next;
        size--;
        return true;
    }

    /**
     * Exports all members as an {@link ArrayList} for easy rendering in JSP and Servlets.
     *
     * @return an ArrayList containing all MemberNodes in sequential order
     */
    public ArrayList<MemberNode> getAllMembersAsList() {
        ArrayList<MemberNode> list = new ArrayList<>(size);
        MemberNode current = head;
        while (current != null) {
            list.add(current);
            current = current.next;
        }
        return list;
    }

    /**
     * Prints all registered members to standard output.
     */
    public void displayAllMembers() {
        if (head == null) {
            System.out.println("No members are registered.");
            return;
        }

        MemberNode current = head;
        int memberNumber = 1;
        while (current != null) {
            System.out.println(memberNumber + ". " + current);
            current = current.next;
            memberNumber++;
        }
    }

    /**
     * Converts the linked list nodes into a fixed-size array.
     * Primarily utilized by sorting algorithms (MergeSort, QuickSort, BubbleSort, InsertionSort).
     *
     * @return an array of MemberNode objects representing current list elements
     */
    public MemberNode[] toArray() {
        MemberNode[] arr = new MemberNode[size];
        MemberNode current = head;
        int index = 0;
        while (current != null && index < size) {
            arr[index++] = current;
            current = current.next;
        }
        return arr;
    }

    /**
     * Reconstructs the linked list pointer chain from an ordered array of MemberNodes.
     * Updates head, relinks each node's {@code next} pointer, and sets the new size.
     *
     * @param arr the array of MemberNodes (typically resulting from a sort operation)
     */
    public void rebuildFromArray(MemberNode[] arr) {
        if (arr == null || arr.length == 0) {
            this.head = null;
            this.size = 0;
            return;
        }

        this.head = arr[0];
        MemberNode current = this.head;
        for (int i = 1; i < arr.length; i++) {
            current.next = arr[i];
            current = current.next;
        }
        current.next = null; // Terminate list
        this.size = arr.length;
    }

    /**
     * Clears all members from the list, resetting head and size.
     */
    public void clear() {
        this.head = null;
        this.size = 0;
    }
}
