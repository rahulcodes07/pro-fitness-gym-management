package com.profitness.dsa;

/**
 * Represents a single node in the Member Singly Linked List.
 * <p>
 * <b>Data Structure:</b> Singly Linked List Node<br>
 * <b>Pointers:</b> Contains a {@code next} pointer referencing the subsequent member node in the chain.<br>
 * <b>Time Complexity:</b> O(1) for field access and pointer mutation.<br>
 * <b>Gym Application:</b> Stores profile attributes of registered gym members including their unique ID,
 * full name, membership tier (e.g., Annual, Monthly, VIP), and fee payment status.
 * </p>
 */
public class MemberNode {
    public int memberID;
    public String name;
    public String membershipType;
    public String feeStatus;
    public MemberNode next;

    /**
     * Constructs a new MemberNode without an initial successor pointer.
     *
     * @param memberID       Unique numerical identifier for the member
     * @param name           Full name of the gym member
     * @param membershipType Membership category (e.g., Monthly, Quarterly, Annual, VIP)
     * @param feeStatus      Current payment status (e.g., Paid, Pending, Overdue)
     */
    public MemberNode(int memberID, String name, String membershipType, String feeStatus) {
        this.memberID = memberID;
        this.name = name;
        this.membershipType = membershipType;
        this.feeStatus = feeStatus;
        this.next = null;
    }

    /**
     * Constructs a new MemberNode with an explicit successor pointer.
     *
     * @param memberID       Unique numerical identifier for the member
     * @param name           Full name of the gym member
     * @param membershipType Membership category
     * @param feeStatus      Current payment status
     * @param next           Pointer to the next MemberNode in the list
     */
    public MemberNode(int memberID, String name, String membershipType, String feeStatus, MemberNode next) {
        this.memberID = memberID;
        this.name = name;
        this.membershipType = membershipType;
        this.feeStatus = feeStatus;
        this.next = next;
    }

    // Getters and Setters for JSP Bean and OOP encapsulation

    public int getMemberID() {
        return memberID;
    }

    public void setMemberID(int memberID) {
        this.memberID = memberID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMembershipType() {
        return membershipType;
    }

    public void setMembershipType(String membershipType) {
        this.membershipType = membershipType;
    }

    public String getFeeStatus() {
        return feeStatus;
    }

    public void setFeeStatus(String feeStatus) {
        this.feeStatus = feeStatus;
    }

    public MemberNode getNext() {
        return next;
    }

    public void setNext(MemberNode next) {
        this.next = next;
    }

    @Override
    public String toString() {
        return "ID: " + memberID
                + ", Name: " + name
                + ", Membership: " + membershipType
                + ", Fee status: " + feeStatus;
    }
}
