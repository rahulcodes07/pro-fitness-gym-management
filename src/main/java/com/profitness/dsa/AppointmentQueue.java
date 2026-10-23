package com.profitness.dsa;

import java.util.ArrayList;

/**
 * Custom Queue data structure using linked nodes for Gym Trainer Appointments.
 * <p>
 * <b>Data Structure:</b> Queue implemented via Singly Linked List (FIFO - First-In, First-Out).<br>
 * <b>Pointers:</b> Maintains both {@code front} and {@code rear} pointers to enable constant time operations,
 * alongside an integer {@code size}.<br>
 * <b>Time Complexities:</b>
 * <ul>
 *   <li>Enqueue (enqueue): O(1) constant time insertion at the rear pointer.</li>
 *   <li>Dequeue (dequeue): O(1) constant time removal from the front pointer.</li>
 *   <li>Peek (peek): O(1) inspection of the front element without removal.</li>
 *   <li>Size / IsEmpty: O(1).</li>
 *   <li>Export (getAllAppointmentsAsList): O(n) linear traversal from front to rear.</li>
 * </ul>
 * <b>Gym Application:</b> Manages booking requests for personal trainers ensuring fair, chronological
 * processing so that members are served in the exact order requests were received.
 * </p>
 */
public class AppointmentQueue {
    private AppointmentNode front;
    private AppointmentNode rear;
    private int size;

    /**
     * Initializes an empty AppointmentQueue.
     */
    public AppointmentQueue() {
        this.front = null;
        this.rear = null;
        this.size = 0;
    }

    /**
     * Checks if the appointment queue is empty.
     *
     * @return true if no appointments are waiting, false otherwise
     */
    public boolean isEmpty() {
        return front == null;
    }

    /**
     * Returns the count of pending appointments in the queue.
     *
     * @return number of appointments queued
     */
    public int getSize() {
        return size;
    }

    /**
     * Enqueues a new trainer appointment request at the rear of the queue.
     *
     * @param memberID         Member's unique identification number
     * @param memberName       Member's name
     * @param requestedTrainer Name of the preferred trainer
     * @param requestedTime    Preferred time slot
     */
    public void enqueue(int memberID, String memberName, String requestedTrainer, String requestedTime) {
        AppointmentNode newNode = new AppointmentNode(memberID, memberName, requestedTrainer, requestedTime);

        if (rear == null) {
            front = newNode;
            rear = newNode;
        } else {
            rear.next = newNode;
            rear = newNode;
        }

        size++;
    }

    /**
     * Dequeues and returns the next pending appointment from the front of the queue.
     *
     * @return the processed AppointmentNode, or null if queue is empty
     */
    public AppointmentNode dequeue() {
        if (front == null) {
            return null;
        }

        AppointmentNode processedAppointment = front;
        front = front.next;
        processedAppointment.next = null;
        size--;

        if (front == null) {
            rear = null;
        }

        return processedAppointment;
    }

    /**
     * Peeks at the next pending appointment at the front of the queue without removing it.
     *
     * @return the front AppointmentNode, or null if queue is empty
     */
    public AppointmentNode peek() {
        return front;
    }

    /**
     * Exports all pending appointments in FIFO arrival order as an {@link ArrayList}
     * for JSP and servlet display.
     *
     * @return list of pending appointments from earliest to latest
     */
    public ArrayList<AppointmentNode> getAllAppointmentsAsList() {
        ArrayList<AppointmentNode> list = new ArrayList<>(size);
        AppointmentNode current = front;
        while (current != null) {
            list.add(current);
            current = current.next;
        }
        return list;
    }

    /**
     * Displays all pending appointments to standard output in chronological order.
     */
    public void displayAppointments() {
        if (front == null) {
            System.out.println("There are no pending trainer appointments.");
            return;
        }

        System.out.println("Appointments are shown in request order:");
        AppointmentNode current = front;
        int position = 1;
        while (current != null) {
            System.out.println(position + ". " + current);
            current = current.next;
            position++;
        }
    }

    /**
     * Clears all appointments from the queue.
     */
    public void clear() {
        this.front = null;
        this.rear = null;
        this.size = 0;
    }
}
