package com.profitness.dsa;

import java.util.ArrayList;

/**
 * Represents a fitness trainer's credentials, core specialization,
 * and current schedule commitments.
 * <p>
 * <b>Data Structure & Domain Entity:</b><br>
 * Represents a resource agent in constraint satisfaction problems with domain variables
 * (specialization compatibility and time slot availability).
 * </p>
 * <p>
 * <b>Time Complexity:</b><br>
 * O(K) for slot availability search and booking operations where K is the number of slots.
 * </p>
 * <p>
 * <b>Gym Application:</b><br>
 * Holds instructor profiles such as "Arjun (Specialization: Strength)" with open shifts
 * like ["09:00 AM", "10:00 AM", "11:00 AM"].
 * </p>
 */
public class TrainerProfile {
    private String name;
    private String specialization;
    private ArrayList<String> availableSlots;
    private ArrayList<String> assignedSlots;

    /**
     * Constructs a TrainerProfile with initial available time slots.
     *
     * @param name           Full name of the fitness trainer
     * @param specialization Athletic focus (e.g., "Strength", "Cardio", "Flexibility", "CrossFit")
     * @param availableSlots List of working time slots for the trainer
     */
    public TrainerProfile(String name, String specialization, ArrayList<String> availableSlots) {
        this.name = name;
        this.specialization = specialization;
        this.availableSlots = (availableSlots != null) ? new ArrayList<>(availableSlots) : new ArrayList<>();
        this.assignedSlots = new ArrayList<>();
    }

    /**
     * Constructs a TrainerProfile with both available and currently assigned slots.
     *
     * @param name           Full name of the fitness trainer
     * @param specialization Athletic focus
     * @param availableSlots List of working time slots
     * @param assignedSlots  List of pre-booked time slots
     */
    public TrainerProfile(String name, String specialization, ArrayList<String> availableSlots, ArrayList<String> assignedSlots) {
        this.name = name;
        this.specialization = specialization;
        this.availableSlots = (availableSlots != null) ? new ArrayList<>(availableSlots) : new ArrayList<>();
        this.assignedSlots = (assignedSlots != null) ? new ArrayList<>(assignedSlots) : new ArrayList<>();
    }

    /**
     * Checks if a specified time slot is listed in the trainer's working hours
     * and is not currently occupied by another member.
     *
     * @param slot Desired time slot (e.g. "09:00 AM")
     * @return {@code true} if free to book, {@code false} if already assigned or not offered
     */
    public boolean isSlotAvailable(String slot) {
        if (slot == null || availableSlots == null) {
            return false;
        }
        boolean offered = false;
        for (String s : availableSlots) {
            if (s.trim().equalsIgnoreCase(slot.trim())) {
                offered = true;
                break;
            }
        }
        if (!offered) {
            return false;
        }

        if (assignedSlots != null) {
            for (String s : assignedSlots) {
                if (s.trim().equalsIgnoreCase(slot.trim())) {
                    return false; // Already booked
                }
            }
        }
        return true;
    }

    /**
     * Books a time slot for this trainer.
     *
     * @param slot The time slot to reserve
     * @return {@code true} if successfully booked, {@code false} if slot was not free
     */
    public boolean bookSlot(String slot) {
        if (!isSlotAvailable(slot)) {
            return false;
        }
        if (assignedSlots == null) {
            assignedSlots = new ArrayList<>();
        }
        assignedSlots.add(slot.trim());
        return true;
    }

    /**
     * Releases an allocated slot (used during backtracking recursion).
     *
     * @param slot The time slot to free
     * @return {@code true} if found and removed, {@code false} otherwise
     */
    public boolean releaseSlot(String slot) {
        if (assignedSlots == null || slot == null) {
            return false;
        }
        for (int i = 0; i < assignedSlots.size(); i++) {
            if (assignedSlots.get(i).trim().equalsIgnoreCase(slot.trim())) {
                assignedSlots.remove(i);
                return true;
            }
        }
        return false;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSpecialization() {
        return specialization;
    }

    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }

    public ArrayList<String> getAvailableSlots() {
        return availableSlots;
    }

    public void setAvailableSlots(ArrayList<String> availableSlots) {
        this.availableSlots = availableSlots != null ? availableSlots : new ArrayList<>();
    }

    public ArrayList<String> getAssignedSlots() {
        return assignedSlots;
    }

    public void setAssignedSlots(ArrayList<String> assignedSlots) {
        this.assignedSlots = assignedSlots != null ? assignedSlots : new ArrayList<>();
    }

    @Override
    public String toString() {
        return String.format("%s [%s] Booked: %d/%d slots",
                name, specialization,
                (assignedSlots != null ? assignedSlots.size() : 0),
                (availableSlots != null ? availableSlots.size() : 0));
    }
}
