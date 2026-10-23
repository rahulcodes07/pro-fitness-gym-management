package com.profitness.web;

import com.profitness.dsa.DataStore;

import com.profitness.dsa.MemberLinkedList;
import com.profitness.dsa.MemberNode;
import com.profitness.dsa.SearchAlgorithms;
import com.profitness.dsa.SearchResult;
import com.profitness.dsa.SortAlgorithms;
import com.profitness.dsa.SortResult;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Servlet providing interactive searching (Linear vs Binary) and sorting
 * (Insertion Sort vs Merge Sort) benchmarks on gym member records.
 */
public class SearchSortServlet extends HttpServlet {

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
            request.setAttribute("memberCount", members.getSize());

            request.getRequestDispatcher("/search-sort.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading search & sort module: " + e.getMessage());
            request.getRequestDispatcher("/search-sort.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        DataStore store = DataStore.getInstance();
        MemberLinkedList members = store.getMembers();
        MemberNode[] memberArray = members.toArray();

        // Always pass base member details
        request.setAttribute("memberList", members.getAllMembersAsList());
        request.setAttribute("memberCount", members.getSize());

        try {
            if ("search".equalsIgnoreCase(action)) {
                String idStr = request.getParameter("targetID");
                if (idStr == null || idStr.trim().isEmpty()) {
                    request.setAttribute("errorMessage", "Please provide a valid Member ID to search.");
                } else {
                    int targetID = Integer.parseInt(idStr.trim());

                    // 1. Linear Search on original array
                    SearchResult linearResult = SearchAlgorithms.linearSearch(memberArray, targetID);

                    // 2. Sort array for Binary Search precondition
                    SortResult preSort = SortAlgorithms.mergeSort(memberArray);
                    SearchResult binaryResult = SearchAlgorithms.binarySearch(preSort.getSortedArray(), targetID);

                    request.setAttribute("targetID", targetID);
                    request.setAttribute("linearResult", linearResult);
                    request.setAttribute("binaryResult", binaryResult);
                    request.setAttribute("activeTab", "search");

                    if (linearResult.isFound()) {
                        request.setAttribute("message", "Search complete! Target ID " + targetID + " found: Linear ("
                                + linearResult.getComparisons() + " comparisons), Binary ("
                                + binaryResult.getComparisons() + " comparisons).");
                    } else {
                        request.setAttribute("errorMessage", "Member ID " + targetID + " not found after searching all records.");
                    }
                }

            } else if ("sort".equalsIgnoreCase(action)) {
                String sortType = request.getParameter("sortType");
                if (sortType == null) sortType = "merge";

                SortResult sortResult;
                if ("insertion".equalsIgnoreCase(sortType)) {
                    sortResult = SortAlgorithms.insertionSort(memberArray);
                } else {
                    sortType = "merge";
                    sortResult = SortAlgorithms.mergeSort(memberArray);
                }

                request.setAttribute("sortResult", sortResult);
                request.setAttribute("sortType", sortType);
                request.setAttribute("activeTab", "sort");
                request.setAttribute("message", sortResult.getAlgorithmName() + " finished in "
                        + String.format("%.4f", sortResult.getTimeMillis()) + " ms ("
                        + sortResult.getComparisons() + " comparisons, "
                        + sortResult.getSwapsOrMerges() + " shifts/merges).");

            } else if ("compare-sort".equalsIgnoreCase(action)) {
                SortResult insertionRes = SortAlgorithms.insertionSort(memberArray);
                SortResult mergeRes = SortAlgorithms.mergeSort(memberArray);

                request.setAttribute("insertionResult", insertionRes);
                request.setAttribute("mergeResult", mergeRes);
                request.setAttribute("isComparison", true);
                request.setAttribute("activeTab", "compare");
                request.setAttribute("message", "Sorting comparison executed! Insertion Sort: "
                        + insertionRes.getComparisons() + " comparisons vs. Merge Sort: "
                        + mergeRes.getComparisons() + " comparisons.");

            } else {
                request.setAttribute("errorMessage", "Unknown action: " + action);
            }

            request.getRequestDispatcher("/search-sort.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid numeric ID format: " + e.getMessage());
            request.getRequestDispatcher("/search-sort.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error processing algorithm: " + e.getMessage());
            request.getRequestDispatcher("/search-sort.jsp").forward(request, response);
        }
    }
}
