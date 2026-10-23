package com.profitness.web;

import com.profitness.dsa.DataStore;

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
 * Servlet handling Member Management operations via custom Singly Linked List
 * and synchronized Member Binary Search Tree.
 */
public class MemberServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            DataStore store = DataStore.getInstance();
            MemberLinkedList members = store.getMembers();

            String message = request.getParameter("message");
            String error = request.getParameter("error");

            if (message != null && !message.trim().isEmpty()) {
                request.setAttribute("message", message);
            }
            if (error != null && !error.trim().isEmpty()) {
                request.setAttribute("errorMessage", error);
            }

            request.setAttribute("memberList", members.getAllMembersAsList());
            request.setAttribute("totalMembers", members.getSize());

            request.getRequestDispatcher("/members.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading members: " + e.getMessage());
            request.getRequestDispatcher("/members.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        DataStore store = DataStore.getInstance();
        MemberLinkedList members = store.getMembers();

        try {
            if ("add".equalsIgnoreCase(action)) {
                String idStr = request.getParameter("memberID");
                String name = request.getParameter("name");
                String membershipType = request.getParameter("membershipType");
                String feeStatus = request.getParameter("feeStatus");

                if (idStr == null || name == null || idStr.trim().isEmpty() || name.trim().isEmpty()) {
                    redirectWithError(request, response, "Member ID and Name are required fields.");
                    return;
                }

                int memberID = Integer.parseInt(idStr.trim());
                name = name.trim();
                membershipType = (membershipType != null && !membershipType.trim().isEmpty()) ? membershipType.trim() : "Standard";
                feeStatus = (feeStatus != null && !feeStatus.trim().isEmpty()) ? feeStatus.trim() : "Pending";

                boolean added = members.addMember(memberID, name, membershipType, feeStatus);
                if (added) {
                    store.getMemberBST().insert(memberID, name);
                    store.saveMembers();
                    redirectWithMessage(request, response, "Member " + name + " (ID: " + memberID + ") registered successfully!");
                } else {
                    redirectWithError(request, response, "Registration failed: Member ID " + memberID + " already exists.");
                }

            } else if ("delete".equalsIgnoreCase(action)) {
                String idStr = request.getParameter("memberID");
                if (idStr == null || idStr.trim().isEmpty()) {
                    redirectWithError(request, response, "Please specify a Member ID to delete.");
                    return;
                }

                int memberID = Integer.parseInt(idStr.trim());
                boolean removed = members.removeMemberById(memberID);
                if (removed) {
                    store.getMemberBST().delete(memberID);
                    store.saveMembers();
                    redirectWithMessage(request, response, "Member ID " + memberID + " deleted successfully.");
                } else {
                    redirectWithError(request, response, "Could not delete: Member ID " + memberID + " was not found.");
                }

            } else if ("update".equalsIgnoreCase(action)) {
                String idStr = request.getParameter("memberID");
                String name = request.getParameter("name");
                String membershipType = request.getParameter("membershipType");
                String feeStatus = request.getParameter("feeStatus");

                if (idStr == null || idStr.trim().isEmpty()) {
                    redirectWithError(request, response, "Member ID is required to update records.");
                    return;
                }

                int memberID = Integer.parseInt(idStr.trim());
                name = (name != null) ? name.trim() : "";
                membershipType = (membershipType != null) ? membershipType.trim() : "";
                feeStatus = (feeStatus != null) ? feeStatus.trim() : "";

                boolean updated = members.updateMember(memberID, name, membershipType, feeStatus);
                if (updated) {
                    store.getMemberBST().insert(memberID, name);
                    store.saveMembers();
                    redirectWithMessage(request, response, "Member ID " + memberID + " updated successfully!");
                } else {
                    redirectWithError(request, response, "Update failed: Member ID " + memberID + " does not exist.");
                }

            } else if ("find".equalsIgnoreCase(action)) {
                String idStr = request.getParameter("memberID");
                if (idStr == null || idStr.trim().isEmpty()) {
                    request.setAttribute("errorMessage", "Please provide a valid Member ID to find.");
                } else {
                    try {
                        int memberID = Integer.parseInt(idStr.trim());
                        MemberNode found = members.findMemberById(memberID);
                        if (found != null) {
                            request.setAttribute("foundMember", found);
                            request.setAttribute("message", "Member ID " + memberID + " found.");
                        } else {
                            request.setAttribute("errorMessage", "No member found with ID " + memberID + ".");
                        }
                    } catch (NumberFormatException nfe) {
                        request.setAttribute("errorMessage", "Invalid Member ID format. Must be a whole number.");
                    }
                }

                request.setAttribute("memberList", members.getAllMembersAsList());
                request.setAttribute("totalMembers", members.getSize());
                request.getRequestDispatcher("/members.jsp").forward(request, response);

            } else {
                redirectWithError(request, response, "Unknown action: " + action);
            }
        } catch (NumberFormatException e) {
            redirectWithError(request, response, "Invalid number format for Member ID: " + e.getMessage());
        } catch (Exception e) {
            redirectWithError(request, response, "An error occurred: " + e.getMessage());
        }
    }

    private void redirectWithMessage(HttpServletRequest request, HttpServletResponse response, String message)
            throws IOException {
        String encoded = URLEncoder.encode(message, StandardCharsets.UTF_8);
        response.sendRedirect(request.getContextPath() + "/members?message=" + encoded);
    }

    private void redirectWithError(HttpServletRequest request, HttpServletResponse response, String error)
            throws IOException {
        String encoded = URLEncoder.encode(error, StandardCharsets.UTF_8);
        response.sendRedirect(request.getContextPath() + "/members?error=" + encoded);
    }
}
