package com.profitness.web;

import com.profitness.dsa.DataStore;

import com.profitness.dsa.AppointmentNode;
import com.profitness.dsa.AppointmentQueue;
import com.profitness.dsa.MemberLinkedList;
import com.profitness.dsa.MemberNode;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

/**
 * Servlet handling Trainer Appointment requests using a FIFO AppointmentQueue.
 */
public class AppointmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            DataStore store = DataStore.getInstance();
            AppointmentQueue queue = store.getAppointmentQueue();
            MemberLinkedList members = store.getMembers();

            String message = request.getParameter("message");
            String error = request.getParameter("error");

            if (message != null && !message.trim().isEmpty()) {
                request.setAttribute("message", message);
            }
            if (error != null && !error.trim().isEmpty()) {
                request.setAttribute("errorMessage", error);
            }

            request.setAttribute("appointmentList", queue.getAllAppointmentsAsList());
            request.setAttribute("totalAppointments", queue.getSize());
            request.setAttribute("nextAppointment", queue.peek());
            request.setAttribute("registeredMembers", members.getAllMembersAsList());

            request.getRequestDispatcher("/appointments.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading appointments: " + e.getMessage());
            request.getRequestDispatcher("/appointments.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        DataStore store = DataStore.getInstance();
        AppointmentQueue queue = store.getAppointmentQueue();
        MemberLinkedList members = store.getMembers();

        try {
            if ("request".equalsIgnoreCase(action)) {
                String idStr = request.getParameter("memberID");
                String trainer = request.getParameter("trainer");
                String requestedTime = request.getParameter("time");

                if (idStr == null || idStr.trim().isEmpty() || trainer == null || trainer.trim().isEmpty()) {
                    redirectWithError(request, response, "Member ID and Trainer selection are required.");
                    return;
                }

                int memberID = Integer.parseInt(idStr.trim());
                MemberNode member = members.findMemberById(memberID);

                if (member == null) {
                    redirectWithError(request, response, "Booking failed: Member ID " + memberID + " is not registered in the system.");
                    return;
                }

                trainer = trainer.trim();
                requestedTime = (requestedTime != null && !requestedTime.trim().isEmpty()) ? requestedTime.trim() : "10:00 AM";

                queue.enqueue(member.memberID, member.name, trainer, requestedTime);
                store.saveAppointments();

                redirectWithMessage(request, response, "Appointment request for " + member.name + " with Trainer " + trainer + " at " + requestedTime + " added to Queue (FIFO)!");

            } else if ("process".equalsIgnoreCase(action)) {
                AppointmentNode processed = queue.dequeue();

                if (processed == null) {
                    redirectWithError(request, response, "No pending appointments to process.");
                } else {
                    store.saveAppointments();
                    redirectWithMessage(request, response, "Appointment processed for " + processed.memberName + " (ID: " + processed.memberID + ") with " + processed.requestedTrainer + " at " + processed.requestedTime + " (FIFO Dequeued).");
                }

            } else {
                redirectWithError(request, response, "Unknown appointment action: " + action);
            }
        } catch (NumberFormatException e) {
            redirectWithError(request, response, "Invalid Member ID format: " + e.getMessage());
        } catch (Exception e) {
            redirectWithError(request, response, "Error managing appointment: " + e.getMessage());
        }
    }

    private void redirectWithMessage(HttpServletRequest request, HttpServletResponse response, String message)
            throws IOException {
        String encoded = URLEncoder.encode(message, StandardCharsets.UTF_8);
        response.sendRedirect(request.getContextPath() + "/appointments?message=" + encoded);
    }

    private void redirectWithError(HttpServletRequest request, HttpServletResponse response, String error)
            throws IOException {
        String encoded = URLEncoder.encode(error, StandardCharsets.UTF_8);
        response.sendRedirect(request.getContextPath() + "/appointments?error=" + encoded);
    }
}
