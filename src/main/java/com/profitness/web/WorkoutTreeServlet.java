package com.profitness.web;

import com.profitness.dsa.DataStore;

import com.profitness.dsa.WorkoutBinaryTree;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

/**
 * Servlet presenting the Hierarchical Workout Binary Tree and handling
 * Pre-order, In-order, and Post-order tree traversals with visual step traces.
 */
public class WorkoutTreeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            DataStore store = DataStore.getInstance();
            WorkoutBinaryTree tree = store.getWorkoutTree();

            populateDefaultTraversals(request, tree);

            String message = request.getParameter("message");
            if (message != null && !message.trim().isEmpty()) {
                request.setAttribute("message", message);
            }

            request.getRequestDispatcher("/workout-plans.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading workout plans: " + e.getMessage());
            request.getRequestDispatcher("/workout-plans.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        DataStore store = DataStore.getInstance();
        WorkoutBinaryTree tree = store.getWorkoutTree();

        try {
            populateDefaultTraversals(request, tree);

            if ("traverse".equalsIgnoreCase(action)) {
                String traversalType = request.getParameter("traversalType");
                if (traversalType == null) traversalType = "preorder";

                ArrayList<String> result;
                ArrayList<String> steps;
                String typeName;

                switch (traversalType.toLowerCase()) {
                    case "inorder":
                        result = tree.inorderTraversal();
                        steps = tree.inorderSteps();
                        typeName = "In-Order (Left → Root → Right)";
                        break;
                    case "postorder":
                        result = tree.postorderTraversal();
                        steps = tree.postorderSteps();
                        typeName = "Post-Order (Left → Right → Root)";
                        break;
                    case "preorder":
                    default:
                        traversalType = "preorder";
                        result = tree.preorderTraversal();
                        steps = tree.preorderSteps();
                        typeName = "Pre-Order (Root → Left → Right)";
                        break;
                }

                request.setAttribute("selectedTraversal", traversalType);
                request.setAttribute("traversalTypeName", typeName);
                request.setAttribute("traversalResult", result);
                request.setAttribute("traversalSteps", steps);
                request.setAttribute("message", typeName + " executed successfully with " + result.size() + " categories traversed.");

            } else {
                request.setAttribute("errorMessage", "Unknown action: " + action);
            }

            request.getRequestDispatcher("/workout-plans.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error executing tree traversal: " + e.getMessage());
            request.getRequestDispatcher("/workout-plans.jsp").forward(request, response);
        }
    }

    private void populateDefaultTraversals(HttpServletRequest request, WorkoutBinaryTree tree) {
        request.setAttribute("preorderList", tree.preorderTraversal());
        request.setAttribute("inorderList", tree.inorderTraversal());
        request.setAttribute("postorderList", tree.postorderTraversal());
        request.setAttribute("treeRoot", tree.getRoot());
    }
}
