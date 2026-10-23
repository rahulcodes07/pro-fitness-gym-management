package com.profitness.web;

import com.profitness.dsa.DataStore;

import com.profitness.dsa.GreedyScheduler;
import com.profitness.dsa.ScheduleResult;
import com.profitness.dsa.TrainerSession;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

/**
 * Servlet demonstrating the Greedy Algorithm paradigm applied to fitness operations:
 * Greedy Activity Selection for Optimal Trainer Session Scheduling.
 *
 * <p><b>Why Greedy?</b><br>
 * The trainer scheduling problem maps directly to the classic Activity Selection Problem.
 * A greedy approach is optimal here because choosing the session that finishes earliest
 * always leaves maximum remaining time for subsequent sessions. This satisfies both the
 * Greedy Choice Property and Optimal Substructure, guaranteeing a globally optimal schedule
 * without exploring exponential permutations.</p>
 */
public class AlgorithmServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("sampleGreedySessions", getSampleGreedySessions());

            String message = request.getParameter("message");
            String error = request.getParameter("error");

            if (message != null && !message.trim().isEmpty()) {
                request.setAttribute("message", message);
            }
            if (error != null && !error.trim().isEmpty()) {
                request.setAttribute("errorMessage", error);
            }

            request.getRequestDispatcher("/algorithms.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading greedy scheduler: " + e.getMessage());
            request.getRequestDispatcher("/algorithms.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("sampleGreedySessions", getSampleGreedySessions());

        try {
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
            request.setAttribute("message", "Greedy Scheduling complete: "
                    + scheduleResult.getTotalSessionsScheduled() + " of "
                    + scheduleResult.getTotalSessionsRequested() + " sessions scheduled across "
                    + numTrainers + " trainers.");

            request.getRequestDispatcher("/algorithms.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error executing greedy scheduler: " + e.getMessage());
            request.getRequestDispatcher("/algorithms.jsp").forward(request, response);
        }
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
}
