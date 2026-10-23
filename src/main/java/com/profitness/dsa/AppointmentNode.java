package com.profitness.dsa;

/**
 * Node structure for the Trainer Appointment Queue.
 * <p>
 * <b>Data Structure:</b> Queue Node (Linked implementation)<br>
 * <b>Pointers:</b> Contains a {@code next} pointer referencing the subsequent appointment in the queue.<br>
 * <b>Time Complexity:</b> O(1) for creation and pointer reassignment.<br>
 * <b>Gym Application:</b> Represents a member's pending appointment request with a personal trainer,
 * recording member ID, member name, requested trainer, and preferred time slot.
 * </p>
 */
public class AppointmentNode {
    public int memberID;
    public String memberName;
    public String requestedTrainer;
    public String requestedTime;
    public AppointmentNode next;

    /**
     * Constructs an AppointmentNode without an initial successor pointer.
     *
     * @param memberID         Unique ID of the member requesting the session
     * @param memberName       Full name of the member
     * @param requestedTrainer Name of the assigned or requested personal trainer
     * @param requestedTime    Requested time slot (e.g., "10:00 AM", "18:00")
     */
    public AppointmentNode(int memberID, String memberName, String requestedTrainer, String requestedTime) {
        this.memberID = memberID;
        this.memberName = memberName;
        this.requestedTrainer = requestedTrainer;
        this.requestedTime = requestedTime;
        this.next = null;
    }

    /**
     * Constructs an AppointmentNode with an explicit successor pointer.
     *
     * @param memberID         Unique ID of the member requesting the session
     * @param memberName       Full name of the member
     * @param requestedTrainer Name of the assigned or requested personal trainer
     * @param requestedTime    Requested time slot
     * @param next             Pointer to the next AppointmentNode in the queue
     */
    public AppointmentNode(int memberID, String memberName, String requestedTrainer, String requestedTime, AppointmentNode next) {
        this.memberID = memberID;
        this.memberName = memberName;
        this.requestedTrainer = requestedTrainer;
        this.requestedTime = requestedTime;
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

    public String getRequestedTrainer() {
        return requestedTrainer;
    }

    public void setRequestedTrainer(String requestedTrainer) {
        this.requestedTrainer = requestedTrainer;
    }

    public String getRequestedTime() {
        return requestedTime;
    }

    public void setRequestedTime(String requestedTime) {
        this.requestedTime = requestedTime;
    }

    public AppointmentNode getNext() {
        return next;
    }

    public void setNext(AppointmentNode next) {
        this.next = next;
    }

    @Override
    public String toString() {
        return "Member ID: " + memberID
                + ", Name: " + memberName
                + ", Trainer: " + requestedTrainer
                + ", Requested time: " + requestedTime;
    }
}
