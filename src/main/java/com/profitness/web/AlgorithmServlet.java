package com.profitness.web;

import com.profitness.dsa.DataStore;

import com.profitness.dsa.AssignmentResult;
import com.profitness.dsa.BacktrackingAssigner;
import com.profitness.dsa.GreedyScheduler;
import com.profitness.dsa.KnapsackResult;
import com.profitness.dsa.KnapsackSolver;
import com.profitness.dsa.MemberRequest;
import com.profitness.dsa.ScheduleResult;
import com.profitness.dsa.TrainerProfile;
import com.profitness.dsa.TrainerSession;
import com.profitness.dsa.WorkoutExercise;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

/**
 * Servlet demonstrating advanced DSA algorithmic paradigms applied to fitness operations:
 * 1. Greedy Algorithm: Optimal Trainer Activity Scheduling
 * 2. Dynamic Programming: 0/1 Knapsack Workout Session Optimization
 * 3. Backtracking: Member-to-Trainer Constraint Satisfaction Problem (CSP)
 */
public class AlgorithmServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            populateSampleAttributes(request);

            String message = request.getParameter("message");
            String error = request.getParameter("error");

            if (message != null && !message.trim().isEmpty()) {
                request.setAttribute("message", message);
            }
            if (error != null && !error.trim().isEmpty()) {
                request.setAttribute("errorMessage", error);
            }

            request.setAttribute("activeTab", "greedy");
            request.getRequestDispatcher("/algorithms.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading algorithms module: " + e.getMessage());
            request.getRequestDispatcher("/algorithms.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        populateSampleAttributes(request);

        try {
            if ("greedy".equalsIgnoreCase(action)) {
                int numTrainers = 5;
                String trainerCountStr = request.getParameter("numTrainers");
                if (trainerCountStr != null && !trainerCountStr.trim().isEmpty()) {
                    try {
                        numTrainers = Integer.parseInt(trainerCountStr.trim());
                    } catch (NumberFormatException ignored) {
                    }
                }

                ArrayList<TrainerSession> sessions = parseGreedySessions(request);
                if (sessions.isEmpty()) {
                    sessions = getSampleGreedySessions();
                }

                ScheduleResult scheduleResult = GreedyScheduler.schedule(sessions, numTrainers);

                request.setAttribute("scheduleResult", scheduleResult);
                request.setAttribute("greedySessions", sessions);
                request.setAttribute("selectedTrainerCount", numTrainers);
                request.setAttribute("activeTab", "greedy");
                request.setAttribute("message", "Greedy Scheduling complete: "
                        + scheduleResult.getTotalSessionsScheduled() + " of "
                        + scheduleResult.getTotalSessionsRequested() + " sessions scheduled across "
                        + numTrainers + " trainers.");

            } else if ("knapsack".equalsIgnoreCase(action)) {
                int timeLimit = 45;
                String timeLimitStr = request.getParameter("timeLimit");
                if (timeLimitStr != null && !timeLimitStr.trim().isEmpty()) {
                    try {
                        timeLimit = Integer.parseInt(timeLimitStr.trim());
                    } catch (NumberFormatException ignored) {
                    }
                }

                ArrayList<WorkoutExercise> exercises = parseKnapsackExercises(request);
                if (exercises.isEmpty()) {
                    exercises = getSampleExercises();
                }

                KnapsackResult knapsackResult = KnapsackSolver.solve(exercises, timeLimit);

                request.setAttribute("knapsackResult", knapsackResult);
                request.setAttribute("candidateExercises", exercises);
                request.setAttribute("selectedTimeLimit", timeLimit);
                request.setAttribute("activeTab", "knapsack");
                request.setAttribute("message", "0/1 Knapsack Optimization finished: Selected "
                        + knapsackResult.getSelectedExercises().size() + " exercises for total fitness value of "
                        + knapsackResult.getTotalFitnessValue() + " within " + knapsackResult.getTotalTimeCost()
                        + " / " + timeLimit + " minutes.");

            } else if ("backtracking".equalsIgnoreCase(action)) {
                ArrayList<MemberRequest> requests = parseMemberRequests(request);
                if (requests.isEmpty()) {
                    requests = getSampleMemberRequests();
                }

                ArrayList<TrainerProfile> trainers = getSampleTrainerProfiles();

                AssignmentResult assignmentResult = BacktrackingAssigner.assign(requests, trainers);

                request.setAttribute("assignmentResult", assignmentResult);
                request.setAttribute("memberRequests", requests);
                request.setAttribute("trainerProfiles", trainers);
                request.setAttribute("activeTab", "backtracking");
                request.setAttribute("message", "Backtracking Constraint Search finished: "
                        + assignmentResult.getAssignments().size() + " members assigned, "
                        + assignmentResult.getUnassignedMembers().size() + " unassigned ("
                        + assignmentResult.getBacktracks() + " backtracks).");

            } else {
                request.setAttribute("errorMessage", "Unknown algorithm action: " + action);
                request.setAttribute("activeTab", "greedy");
            }

            request.getRequestDispatcher("/algorithms.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error executing algorithm: " + e.getMessage());
            request.setAttribute("activeTab", (action != null ? action : "greedy"));
            request.getRequestDispatcher("/algorithms.jsp").forward(request, response);
        }
    }

    private void populateSampleAttributes(HttpServletRequest request) {
        request.setAttribute("sampleGreedySessions", getSampleGreedySessions());
        request.setAttribute("sampleExercises", getSampleExercises());
        request.setAttribute("sampleMemberRequests", getSampleMemberRequests());
        request.setAttribute("sampleTrainerProfiles", getSampleTrainerProfiles());
    }

    // ==========================================
    // Sample Data Helpers
    // ==========================================

    private ArrayList<TrainerSession> getSampleGreedySessions() {
        ArrayList<TrainerSession> list = new ArrayList<>();
        // Minutes from midnight: 9:00 AM = 540, 10:00 AM = 600, etc.
        list.add(new TrainerSession("Rahul Sharma", 540, 600));   // 9:00 - 10:00 AM
        list.add(new TrainerSession("Ananya Patel", 570, 630));   // 9:30 - 10:30 AM
        list.add(new TrainerSession("Rohan Verma", 600, 660));    // 10:00 - 11:00 AM
        list.add(new TrainerSession("Sneha Reddy", 660, 750));   // 11:00 AM - 12:30 PM
        list.add(new TrainerSession("Amitabh Kumar", 720, 780)); // 12:00 - 1:00 PM
        list.add(new TrainerSession("Pooja Mehta", 840, 900));   // 2:00 - 3:00 PM
        list.add(new TrainerSession("Vikram Malhotra", 870, 960));// 2:30 - 4:00 PM
        list.add(new TrainerSession("Deepika Iyer", 960, 1020));  // 4:00 - 5:00 PM
        return list;
    }

    private ArrayList<WorkoutExercise> getSampleExercises() {
        ArrayList<WorkoutExercise> list = new ArrayList<>();
        list.add(new WorkoutExercise("Treadmill", 15, 7));
        list.add(new WorkoutExercise("HIIT", 20, 9));
        list.add(new WorkoutExercise("Bench Press", 10, 6));
        list.add(new WorkoutExercise("Squats", 12, 8));
        list.add(new WorkoutExercise("Deadlift", 15, 8));
        list.add(new WorkoutExercise("Plank", 5, 4));
        list.add(new WorkoutExercise("Cycling", 20, 7));
        list.add(new WorkoutExercise("Yoga", 25, 5));
        return list;
    }

    private ArrayList<MemberRequest> getSampleMemberRequests() {
        ArrayList<MemberRequest> list = new ArrayList<>();
        list.add(new MemberRequest("Rahul Sharma", "Strength", "Morning"));
        list.add(new MemberRequest("Ananya Patel", "Cardio", "Morning"));
        list.add(new MemberRequest("Rohan Verma", "Strength", "Afternoon"));
        list.add(new MemberRequest("Sneha Reddy", "Flexibility", "Morning"));
        list.add(new MemberRequest("Amitabh Kumar", "Cardio", "Evening"));
        return list;
    }

    private ArrayList<TrainerProfile> getSampleTrainerProfiles() {
        ArrayList<TrainerProfile> list = new ArrayList<>();
        list.add(new TrainerProfile("Arjun", "Strength", new ArrayList<>(Arrays.asList("Morning", "Afternoon"))));
        list.add(new TrainerProfile("Priya", "Cardio", new ArrayList<>(Arrays.asList("Morning", "Evening"))));
        list.add(new TrainerProfile("Vikram", "Strength", new ArrayList<>(Arrays.asList("Afternoon", "Evening"))));
        list.add(new TrainerProfile("Neha", "Flexibility", new ArrayList<>(Arrays.asList("Morning", "Afternoon"))));
        list.add(new TrainerProfile("Karthik", "Cardio", new ArrayList<>(Arrays.asList("Morning", "Afternoon"))));
        return list;
    }

    // ==========================================
    // Request Parsing Helpers
    // ==========================================

    private ArrayList<TrainerSession> parseGreedySessions(HttpServletRequest request) {
        ArrayList<TrainerSession> list = new ArrayList<>();
        String[] members = request.getParameterValues("memberName");
        String[] starts = request.getParameterValues("startTime");
        String[] ends = request.getParameterValues("endTime");

        if (members != null && starts != null && ends != null) {
            int len = Math.min(members.length, Math.min(starts.length, ends.length));
            for (int i = 0; i < len; i++) {
                String m = members[i];
                String s = starts[i];
                String e = ends[i];
                if (m != null && !m.trim().isEmpty() && s != null && e != null) {
                    int startMin = TrainerSession.parseTimeToMinutes(s);
                    int endMin = TrainerSession.parseTimeToMinutes(e);
                    if (startMin >= 0 && endMin > startMin) {
                        list.add(new TrainerSession(m.trim(), startMin, endMin));
                    }
                }
            }
        }
        return list;
    }

    private ArrayList<WorkoutExercise> parseKnapsackExercises(HttpServletRequest request) {
        ArrayList<WorkoutExercise> list = new ArrayList<>();
        String[] names = request.getParameterValues("exerciseName");
        String[] times = request.getParameterValues("exerciseTime");
        String[] values = request.getParameterValues("exerciseValue");

        if (names != null && times != null && values != null) {
            int len = Math.min(names.length, Math.min(times.length, values.length));
            for (int i = 0; i < len; i++) {
                String n = names[i];
                if (n != null && !n.trim().isEmpty()) {
                    try {
                        int t = Integer.parseInt(times[i].trim());
                        int v = Integer.parseInt(values[i].trim());
                        list.add(new WorkoutExercise(n.trim(), t, v));
                    } catch (Exception ignored) {
                    }
                }
            }
        }
        return list;
    }

    private ArrayList<MemberRequest> parseMemberRequests(HttpServletRequest request) {
        ArrayList<MemberRequest> list = new ArrayList<>();
        String[] members = request.getParameterValues("reqMemberName");
        String[] specs = request.getParameterValues("reqSpecialization");
        String[] slots = request.getParameterValues("reqTimeSlot");

        if (members != null && specs != null && slots != null) {
            int len = Math.min(members.length, Math.min(specs.length, slots.length));
            for (int i = 0; i < len; i++) {
                String m = members[i];
                String s = specs[i];
                String sl = slots[i];
                if (m != null && !m.trim().isEmpty() && s != null && sl != null) {
                    list.add(new MemberRequest(m.trim(), s.trim(), sl.trim()));
                }
            }
        }
        return list;
    }
}
