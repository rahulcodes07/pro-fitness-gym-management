package com.profitness.web;

import com.profitness.dsa.DataStore;

import com.profitness.dsa.BSTSearchResult;
import com.profitness.dsa.MemberBST;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

/**
 * Servlet managing the Member Binary Search Tree (BST) index,
 * logarithmic search lookups, and tree rebuilding.
 */
public class BSTServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            DataStore store = DataStore.getInstance();
            MemberBST bst = store.getMemberBST();

            String message = request.getParameter("message");
            String error = request.getParameter("error");

            if (message != null && !message.trim().isEmpty()) {
                request.setAttribute("message", message);
            }
            if (error != null && !error.trim().isEmpty()) {
                request.setAttribute("errorMessage", error);
            }

            request.setAttribute("bstInorder", bst.inorderTraversal());
            request.setAttribute("bstSize", bst.getSize());
            request.setAttribute("bstRoot", bst.getRoot());

            request.getRequestDispatcher("/bst.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading BST: " + e.getMessage());
            request.getRequestDispatcher("/bst.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        DataStore store = DataStore.getInstance();
        MemberBST bst = store.getMemberBST();

        try {
            if ("search".equalsIgnoreCase(action)) {
                String idStr = request.getParameter("targetID");
                if (idStr == null || idStr.trim().isEmpty()) {
                    request.setAttribute("errorMessage", "Please provide a valid Member ID to search in the BST.");
                } else {
                    int targetID = Integer.parseInt(idStr.trim());
                    BSTSearchResult result = bst.search(targetID);
                    request.setAttribute("searchResult", result);
                    request.setAttribute("targetID", targetID);

                    if (result.isFound()) {
                        request.setAttribute("message", "Member ID " + targetID + " (" + result.getFound().memberName + ") located in BST in " + result.getComparisons() + " comparisons.");
                    } else {
                        request.setAttribute("errorMessage", "Member ID " + targetID + " was not found in the BST (inspected " + result.getComparisons() + " nodes).");
                    }
                }

                request.setAttribute("bstInorder", bst.inorderTraversal());
                request.setAttribute("bstSize", bst.getSize());
                request.setAttribute("bstRoot", bst.getRoot());
                request.getRequestDispatcher("/bst.jsp").forward(request, response);

            } else if ("rebuild".equalsIgnoreCase(action)) {
                store.syncBST();
                String msg = "Member BST successfully reconstructed from " + store.getMembers().getSize() + " active member records!";
                response.sendRedirect(request.getContextPath() + "/bst?message=" + URLEncoder.encode(msg, StandardCharsets.UTF_8));

            } else {
                response.sendRedirect(request.getContextPath() + "/bst?error=" + URLEncoder.encode("Unknown BST action: " + action, StandardCharsets.UTF_8));
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid numeric ID: " + e.getMessage());
            request.setAttribute("bstInorder", bst.inorderTraversal());
            request.setAttribute("bstSize", bst.getSize());
            request.setAttribute("bstRoot", bst.getRoot());
            request.getRequestDispatcher("/bst.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error processing BST request: " + e.getMessage());
            request.setAttribute("bstInorder", bst.inorderTraversal());
            request.setAttribute("bstSize", bst.getSize());
            request.setAttribute("bstRoot", bst.getRoot());
            request.getRequestDispatcher("/bst.jsp").forward(request, response);
        }
    }
}
