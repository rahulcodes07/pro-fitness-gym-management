package com.profitness.web;

import com.profitness.dsa.DataStore;

import com.profitness.dsa.BFSResult;
import com.profitness.dsa.DFSResult;
import com.profitness.dsa.GymGraph;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Servlet handling Gym Floor Plan layout visualization and BFS / DFS graph traversals.
 */
public class GraphServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            DataStore store = DataStore.getInstance();
            GymGraph graph = store.getGymGraph();

            String message = request.getParameter("message");
            String error = request.getParameter("error");

            if (message != null && !message.trim().isEmpty()) {
                request.setAttribute("message", message);
            }
            if (error != null && !error.trim().isEmpty()) {
                request.setAttribute("errorMessage", error);
            }

            request.setAttribute("zones", graph.getZones());
            request.setAttribute("adjacencyList", graph.getAdjacencyList());

            request.getRequestDispatcher("/zones.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading gym zones: " + e.getMessage());
            request.getRequestDispatcher("/zones.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String startZone = request.getParameter("startZone");
        DataStore store = DataStore.getInstance();
        GymGraph graph = store.getGymGraph();

        try {
            request.setAttribute("zones", graph.getZones());
            request.setAttribute("adjacencyList", graph.getAdjacencyList());

            if (startZone == null || startZone.trim().isEmpty()) {
                startZone = "Reception";
            }
            startZone = startZone.trim();

            if (!graph.hasZone(startZone)) {
                request.setAttribute("errorMessage", "Zone \"" + startZone + "\" not recognized in the floor plan layout.");
                request.getRequestDispatcher("/zones.jsp").forward(request, response);
                return;
            }

            if ("bfs".equalsIgnoreCase(action)) {
                BFSResult bfsResult = graph.bfsTraversal(startZone);
                request.setAttribute("bfsResult", bfsResult);
                request.setAttribute("traversalType", "BFS");
                request.setAttribute("startZone", startZone);
                request.setAttribute("message", "Breadth-First Search (Queue-based) completed from [" + startZone + "]. Visited " + bfsResult.getVisitOrder().size() + " zones.");

            } else if ("dfs".equalsIgnoreCase(action)) {
                DFSResult dfsResult = graph.dfsTraversal(startZone);
                request.setAttribute("dfsResult", dfsResult);
                request.setAttribute("traversalType", "DFS");
                request.setAttribute("startZone", startZone);
                request.setAttribute("message", "Depth-First Search (Recursive/Backtrack) completed from [" + startZone + "]. Visited " + dfsResult.getVisitOrder().size() + " zones.");

            } else {
                request.setAttribute("errorMessage", "Unknown graph traversal action: " + action);
            }

            request.getRequestDispatcher("/zones.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error executing graph traversal: " + e.getMessage());
            request.getRequestDispatcher("/zones.jsp").forward(request, response);
        }
    }
}
