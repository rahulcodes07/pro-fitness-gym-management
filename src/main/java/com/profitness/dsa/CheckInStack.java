package com.profitness.dsa;

import java.util.ArrayList;

/**
 * Custom Stack data structure using linked nodes for Gym Check-in Session tracking.
 * <p>
 * <b>Data Structure:</b> Stack implemented via Singly Linked List (LIFO - Last-In, First-Out).<br>
 * <b>Pointers:</b> Maintains a reference to the {@code top} node and the active {@code size}.<br>
 * <b>Time Complexities:</b>
 * <ul>
 *   <li>Push (push): O(1) insertion at top of stack.</li>
 *   <li>Pop (pop): O(1) removal of the top node.</li>
 *   <li>Peek (peek): O(1) retrieval of the top element without removal.</li>
 *   <li>Search (isMemberCheckedIn): O(n) traversal from top to bottom.</li>
 *   <li>Export (getAllCheckedInAsList): O(n) traversal.</li>
 * </ul>
 * <b>Gym Application:</b> Tracks members actively working out in the facility. Useful for monitoring
 * real-time gym floor occupancy and auditing the most recent arrivals (LIFO order).
 * </p>
 */
public class CheckInStack {
    private CheckInNode top;
    private int size;

    /**
     * Constructs an empty CheckInStack.
     */
    public CheckInStack() {
        this.top = null;
        this.size = 0;
    }

    /**
     * Checks whether the stack has no check-in records.
     *
     * @return true if stack is empty, false otherwise
     */
    public boolean isEmpty() {
        return top == null;
    }

    /**
     * Returns the number of currently checked-in gym members.
     *
     * @return total active check-ins
     */
    public int getSize() {
        return size;
    }

    /**
     * Pushes a new check-in record onto the top of the stack.
     *
     * @param memberID    ID of the checking-in member
     * @param memberName  Name of the member
     * @param checkInTime Entry timestamp
     */
    public void push(int memberID, String memberName, String checkInTime) {
        CheckInNode newNode = new CheckInNode(memberID, memberName, checkInTime);
        newNode.next = top;
        top = newNode;
        size++;
    }

    /**
     * Pops and returns the most recent check-in record from the top of the stack.
     *
     * @return the most recent CheckInNode, or null if the stack is empty
     */
    public CheckInNode pop() {
        if (top == null) {
            return null;
        }

        CheckInNode checkedOutMember = top;
        top = top.next;
        checkedOutMember.next = null;
        size--;
        return checkedOutMember;
    }

    /**
     * Peeks at the top check-in record without removing it from the stack.
     *
     * @return the top CheckInNode, or null if stack is empty
     */
    public CheckInNode peek() {
        return top;
    }

    /**
     * Checks if a member with the specified ID is currently recorded as checked in.
     *
     * @param memberID the ID to search for
     * @return true if member is currently in the gym, false otherwise
     */
    public boolean isMemberCheckedIn(int memberID) {
        CheckInNode current = top;
        while (current != null) {
            if (current.memberID == memberID) {
                return true;
            }
            current = current.next;
        }
        return false;
    }

    /**
     * Returns all checked-in members in LIFO order (most recent check-in first)
     * as an {@link ArrayList} for JSP and servlet display.
     *
     * @return list of currently checked-in members
     */
    public ArrayList<CheckInNode> getAllCheckedInAsList() {
        ArrayList<CheckInNode> list = new ArrayList<>(size);
        CheckInNode current = top;
        while (current != null) {
            list.add(current);
            current = current.next;
        }
        return list;
    }

    /**
     * Displays all currently checked-in members to the standard console.
     */
    public void displayCheckedInMembers() {
        if (top == null) {
            System.out.println("No members are currently checked in.");
            return;
        }

        System.out.println("Most recent check-in first:");
        CheckInNode current = top;
        int position = 1;
        while (current != null) {
            System.out.println(position + ". " + current);
            current = current.next;
            position++;
        }
    }

    /**
     * Clears all check-ins from the stack.
     */
    public void clear() {
        this.top = null;
        this.size = 0;
    }
}
