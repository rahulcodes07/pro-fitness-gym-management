package com.profitness.web;

import com.profitness.dsa.DataStore;

import com.profitness.dsa.CheckInNode;
import com.profitness.dsa.CheckInStack;
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
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Servlet managing real-time gym floor occupancy using a LIFO CheckInStack.
 */
public class CheckInServlet extends HttpServlet {
    private static final DateTimeFormatter TIME_FORMAT = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            DataStore store = DataStore.getInstance();
            CheckInStack checkInStack = store.getCheckInStack();
            MemberLinkedList members = store.getMembers();

            String message = request.getParameter("message");
            String error = request.getParameter("error");

            if (message != null && !message.trim().isEmpty()) {
                request.setAttribute("message", message);
            }
            if (error != null && !error.trim().isEmpty()) {
                request.setAttribute("errorMessage", error);
            }

            request.setAttribute("checkInList", checkInStack.getAllCheckedInAsList());
            request.setAttribute("totalCheckedIn", checkInStack.getSize());
            request.setAttribute("latestCheckIn", checkInStack.peek());
            request.setAttribute("registeredMembers", members.getAllMembersAsList());

            request.getRequestDispatcher("/checkin.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading check-in data: " + e.getMessage());
            request.getRequestDispatcher("/checkin.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        DataStore store = DataStore.getInstance();
        CheckInStack checkInStack = store.getCheckInStack();
        MemberLinkedList members = store.getMembers();

        try {
            if ("checkin".equalsIgnoreCase(action)) {
                String idStr = request.getParameter("memberID");
                if (idStr == null || idStr.trim().isEmpty()) {
                    redirectWithError(request, response, "Please select or enter a Member ID to check in.");
                    return;
                }

                int memberID = Integer.parseInt(idStr.trim());
                MemberNode member = members.findMemberById(memberID);

                if (member == null) {
                    redirectWithError(request, response, "Cannot check in: Member ID " + memberID + " is not registered.");
                    return;
                }

                if (checkInStack.isMemberCheckedIn(memberID)) {
                    redirectWithError(request, response, member.name + " (ID: " + memberID + ") is already checked in!");
                    return;
                }

                String checkInTime = LocalDateTime.now().format(TIME_FORMAT);
                checkInStack.push(member.memberID, member.name, checkInTime);
                store.saveCheckIns();

                redirectWithMessage(request, response, member.name + " (ID: " + memberID + ") checked in successfully at " + checkInTime + ".");

            } else if ("checkout".equalsIgnoreCase(action)) {
                CheckInNode checkedOut = checkInStack.pop();

                if (checkedOut == null) {
                    redirectWithError(request, response, "Check-out failed: No members are currently checked in.");
                } else {
                    store.saveCheckIns();
                    redirectWithMessage(request, response, checkedOut.memberName + " (ID: " + checkedOut.memberID + ") checked out successfully (LIFO Stack Pop).");
                }

            } else {
                redirectWithError(request, response, "Unknown check-in action: " + action);
            }
        } catch (NumberFormatException e) {
            redirectWithError(request, response, "Invalid Member ID format: " + e.getMessage());
        } catch (Exception e) {
            redirectWithError(request, response, "Error processing check-in: " + e.getMessage());
        }
    }

    private void redirectWithMessage(HttpServletRequest request, HttpServletResponse response, String message)
            throws IOException {
        String encoded = URLEncoder.encode(message, StandardCharsets.UTF_8);
        response.sendRedirect(request.getContextPath() + "/checkin?message=" + encoded);
    }

    private void redirectWithError(HttpServletRequest request, HttpServletResponse response, String error)
            throws IOException {
        String encoded = URLEncoder.encode(error, StandardCharsets.UTF_8);
        response.sendRedirect(request.getContextPath() + "/checkin?error=" + encoded);
    }
}
