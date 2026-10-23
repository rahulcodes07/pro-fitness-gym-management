package com.profitness.dsa;

/**
 * Represents a scheduled or requested personal training session in the gym.
 * <p>
 * <b>Data Structure & Domain Entity:</b><br>
 * Holds temporal activity boundaries (start and end times represented as integer
 * minutes from midnight, e.g. 540 = 9:00 AM) and assigned trainer metadata.
 * </p>
 * <p>
 * <b>Time Complexity:</b><br>
 * O(1) for time conversions, field accessors, and duration computations.
 * </p>
 * <p>
 * <b>Gym Application:</b><br>
 * Used by the {@link GreedyScheduler} activity-selection algorithm to maximize
 * trainer capacity and prevent double-booking of training floors and personal trainers.
 * </p>
 */
public class TrainerSession {
    private String memberName;
    private String trainerName;
    private int startTime; // Minutes from 00:00 (e.g. 540 = 9:00 AM)
    private int endTime;   // Minutes from 00:00 (e.g. 600 = 10:00 AM)
    private int duration;  // Duration in minutes

    /**
     * Constructs a trainer session request with member name and time interval.
     *
     * @param memberName Name of the gym member requesting personal training
     * @param startTime  Session start time in minutes from midnight (0-1440)
     * @param endTime    Session end time in minutes from midnight (0-1440)
     */
    public TrainerSession(String memberName, int startTime, int endTime) {
        this(memberName, "Unassigned", startTime, endTime);
    }

    /**
     * Constructs a fully qualified trainer session with assigned trainer.
     *
     * @param memberName  Name of the gym member
     * @param trainerName Name of the designated fitness trainer
     * @param startTime   Session start time in minutes from midnight
     * @param endTime     Session end time in minutes from midnight
     */
    public TrainerSession(String memberName, String trainerName, int startTime, int endTime) {
        this.memberName = memberName;
        this.trainerName = trainerName;
        this.startTime = startTime;
        this.endTime = endTime;
        this.duration = Math.max(0, endTime - startTime);
    }

    /**
     * Converts integer minutes elapsed since midnight into human-readable 12-hour AM/PM format.
     * Example: 540 -> "9:00 AM", 630 -> "10:30 AM", 780 -> "1:00 PM".
     *
     * @param minutes Total minutes from midnight (0 to 1439)
     * @return Formatted time string (e.g., "9:00 AM")
     */
    public static String formatTime(int minutes) {
        int total = minutes % 1440;
        if (total < 0) {
            total += 1440;
        }
        int hours = total / 60;
        int mins = total % 60;
        String period = (hours >= 12) ? "PM" : "AM";
        int displayHour = hours % 12;
        if (displayHour == 0) {
            displayHour = 12;
        }
        return String.format("%d:%02d %s", displayHour, mins, period);
    }

    /**
     * Parses standard formatted time strings such as "9:00 AM" or "14:30" into integer minutes from midnight.
     *
     * @param timeStr Time string in "H:MM AM/PM" or "HH:MM" format
     * @return Integer minutes from midnight, or -1 if unparseable
     */
    public static int parseTimeToMinutes(String timeStr) {
        if (timeStr == null || timeStr.trim().isEmpty()) {
            return -1;
        }
        try {
            String clean = timeStr.trim().toUpperCase();
            boolean isPm = clean.endsWith("PM");
            boolean isAm = clean.endsWith("AM");

            clean = clean.replace("AM", "").replace("PM", "").trim();
            String[] parts = clean.split(":");
            int hour = Integer.parseInt(parts[0].trim());
            int min = parts.length > 1 ? Integer.parseInt(parts[1].trim()) : 0;

            if (isPm && hour < 12) {
                hour += 12;
            } else if (isAm && hour == 12) {
                hour = 0;
            }

            return hour * 60 + min;
        } catch (Exception e) {
            return -1;
        }
    }

    public String getMemberName() {
        return memberName;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }

    public String getTrainerName() {
        return trainerName;
    }

    public void setTrainerName(String trainerName) {
        this.trainerName = trainerName;
    }

    public int getStartTime() {
        return startTime;
    }

    public void setStartTime(int startTime) {
        this.startTime = startTime;
        this.duration = Math.max(0, this.endTime - this.startTime);
    }

    public int getEndTime() {
        return endTime;
    }

    public void setEndTime(int endTime) {
        this.endTime = endTime;
        this.duration = Math.max(0, this.endTime - this.startTime);
    }

    public int getDuration() {
        return duration;
    }

    public String getFormattedStartTime() {
        return formatTime(startTime);
    }

    public String getFormattedEndTime() {
        return formatTime(endTime);
    }

    @Override
    public String toString() {
        return String.format("[%s | Trainer: %s | %s - %s (%d min)]",
                memberName, trainerName, formatTime(startTime), formatTime(endTime), duration);
    }
}
