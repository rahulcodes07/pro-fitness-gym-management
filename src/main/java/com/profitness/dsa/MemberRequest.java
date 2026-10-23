package com.profitness.dsa;

/**
 * Represents a member's personal training reservation request with specific constraints.
 * <p>
 * <b>Data Structure & Domain Entity:</b><br>
 * Holds constraint variables for the constraint satisfaction problem (CSP)
 * solved via backtracking in {@link BacktrackingAssigner}.
 * </p>
 * <p>
 * <b>Time Complexity:</b><br>
 * O(1) for field access and string representation.
 * </p>
 * <p>
 * <b>Gym Application:</b><br>
 * Captures user preferences submitted through the member portal, specifying
 * which fitness domain they want coaching in (e.g., Cardio, Strength, Flexibility)
 * and their desired workout time slot.
 * </p>
 */
public class MemberRequest {
    private String memberName;
    private String preferredSpecialization;
    private String preferredTimeSlot;

    /**
     * Constructs a MemberRequest constraint item.
     *
     * @param memberName              Name of the member making the request
     * @param preferredSpecialization Desired training discipline (e.g., "Cardio", "Strength", "Flexibility")
     * @param preferredTimeSlot       Preferred hour slot (e.g., "09:00 AM", "10:00 AM", "06:00 PM")
     */
    public MemberRequest(String memberName, String preferredSpecialization, String preferredTimeSlot) {
        this.memberName = memberName;
        this.preferredSpecialization = preferredSpecialization;
        this.preferredTimeSlot = preferredTimeSlot;
    }

    public String getMemberName() {
        return memberName;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }

    public String getPreferredSpecialization() {
        return preferredSpecialization;
    }

    public void setPreferredSpecialization(String preferredSpecialization) {
        this.preferredSpecialization = preferredSpecialization;
    }

    public String getPreferredTimeSlot() {
        return preferredTimeSlot;
    }

    public void setPreferredTimeSlot(String preferredTimeSlot) {
        this.preferredTimeSlot = preferredTimeSlot;
    }

    @Override
    public String toString() {
        return String.format("[%s | Discipline: %s | Slot: %s]",
                memberName, preferredSpecialization, preferredTimeSlot);
    }
}
