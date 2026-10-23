package com.profitness.dsa;

/**
 * Node structure for the Gym Check-in Stack.
 * <p>
 * <b>Data Structure:</b> Stack Node (Linked implementation)<br>
 * <b>Pointers:</b> Contains a {@code next} pointer referencing the element below it on the stack.<br>
 * <b>Time Complexity:</b> O(1) for creation and pointer reassignment.<br>
 * <b>Gym Application:</b> Represents a check-in event when a member enters the gym, capturing their ID,
 * member name, and timestamp of entry.
 * </p>
 */
public class CheckInNode {
    public int memberID;
    public String memberName;
    public String checkInTime;
    public CheckInNode next;

    /**
     * Constructs a CheckInNode with no next pointer.
     *
     * @param memberID    ID of the checked-in member
     * @param memberName  Name of the member
     * @param checkInTime Timestamp string of the check-in
     */
    public CheckInNode(int memberID, String memberName, String checkInTime) {
        this.memberID = memberID;
        this.memberName = memberName;
        this.checkInTime = checkInTime;
        this.next = null;
    }

    /**
     * Constructs a CheckInNode with an explicit next pointer.
     *
     * @param memberID    ID of the checked-in member
     * @param memberName  Name of the member
     * @param checkInTime Timestamp string of the check-in
     * @param next        The node beneath this node in the stack
     */
    public CheckInNode(int memberID, String memberName, String checkInTime, CheckInNode next) {
        this.memberID = memberID;
        this.memberName = memberName;
        this.checkInTime = checkInTime;
        this.next = next;
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

    public String getCheckInTime() {
        return checkInTime;
    }

    public void setCheckInTime(String checkInTime) {
        this.checkInTime = checkInTime;
    }

    public CheckInNode getNext() {
        return next;
    }

    public void setNext(CheckInNode next) {
        this.next = next;
    }

    @Override
    public String toString() {
        return "Member ID: " + memberID
                + ", Name: " + memberName
                + ", Checked in: " + checkInTime;
    }
}
