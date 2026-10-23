package com.profitness.web;

import com.profitness.dsa.ExpressionValidator;
import com.profitness.dsa.ValidationResult;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Servlet handling bracket expression validation requests.
 * Demonstrates Stack application for expression parsing.
 */
public class ExpressionServlet extends HttpServlet {

    private final ExpressionValidator validator = new ExpressionValidator();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String message = request.getParameter("message");
        if (message != null) {
            request.setAttribute("message", message);
        }
        request.getRequestDispatcher("/expression.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String expression = request.getParameter("expression");

        if (expression == null || expression.trim().isEmpty()) {
            request.setAttribute("error", "Please enter an expression to validate.");
            request.getRequestDispatcher("/expression.jsp").forward(request, response);
            return;
        }

        ValidationResult result = validator.validateExpression(expression.trim());

        request.setAttribute("expression", expression.trim());
        request.setAttribute("validationResult", result);
        request.getRequestDispatcher("/expression.jsp").forward(request, response);
    }
}
