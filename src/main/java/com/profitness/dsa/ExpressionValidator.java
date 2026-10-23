package com.profitness.dsa;

import java.util.ArrayList;
import java.util.List;

/**
 * Expression Validator utilizing a custom Linked Stack for bracket and parentheses matching.
 * <p>
 * <b>Data Structure:</b> Custom Character Stack implemented using singly linked {@link CharStackNode} elements.<br>
 * <b>Pointers:</b> Maintains a pointer to the {@code top} of the character stack.<br>
 * <b>Time Complexity:</b> O(n) where n is the length of the expression string (each character is inspected once).<br>
 * <b>Space Complexity:</b> O(n) worst-case memory for stack storage when all brackets are opening.<br>
 * <b>Gym Application:</b> Validates custom workout intensity formulas, caloric burn calculations,
 * and fitness progression equations entered by gym trainers (e.g., {@code {Sets * (Reps + Weight)}}).
 * </p>
 */
public class ExpressionValidator {

    /**
     * Internal node class representing an individual character in the stack.
     */
    private static class CharStackNode {
        char data;
        int index; // Original index in the expression
        CharStackNode next;

        CharStackNode(char data, int index, CharStackNode next) {
            this.data = data;
            this.index = index;
            this.next = next;
        }
    }

    /**
     * Lightweight custom Stack built specifically for bracket characters.
     * Completely built from scratch without java.util collections.
     */
    private static class CharStack {
        private CharStackNode top = null;
        private int count = 0;

        void push(char c, int index) {
            top = new CharStackNode(c, index, top);
            count++;
        }

        CharStackNode pop() {
            if (top == null) {
                return null;
            }
            CharStackNode node = top;
            top = top.next;
            node.next = null;
            count--;
            return node;
        }

        CharStackNode peek() {
            return top;
        }

        boolean isEmpty() {
            return top == null;
        }

        int size() {
            return count;
        }

        /**
         * Renders the current stack state from bottom to top for visual logging.
         */
        String toStackString() {
            if (top == null) {
                return "[]";
            }
            // Reverse order to display bottom -> top
            StringBuilder sb = new StringBuilder();
            CharStackNode curr = top;
            char[] chars = new char[count];
            int i = count - 1;
            while (curr != null && i >= 0) {
                chars[i--] = curr.data;
                curr = curr.next;
            }
            sb.append("[ ");
            for (int j = 0; j < chars.length; j++) {
                sb.append(chars[j]);
                if (j < chars.length - 1) {
                    sb.append(", ");
                }
            }
            sb.append(" ] (Top is '").append(top.data).append("')");
            return sb.toString();
        }
    }

    /**
     * Validates an expression for correctly paired and nested brackets: {@code ()}, {@code []}, and {@code {}}.
     *
     * @param expr the expression string (e.g. "{Sets * (Reps + Weight)}")
     * @return a {@link ValidationResult} containing validity, summary message, and step-by-step trace
     */
    public ValidationResult validateExpression(String expr) {
        List<String> steps = new ArrayList<>();

        if (expr == null) {
            steps.add("Expression is null. Validation aborted.");
            return new ValidationResult(false, "Expression cannot be null.", steps);
        }

        if (expr.trim().isEmpty()) {
            steps.add("Expression is empty. Trivially valid (no brackets found).");
            return new ValidationResult(true, "Expression is empty and valid.", steps);
        }

        steps.add("Starting bracket syntax validation for: \"" + expr + "\"");
        CharStack stack = new CharStack();
        boolean hasBrackets = false;

        for (int i = 0; i < expr.length(); i++) {
            char ch = expr.charAt(i);

            // Handle Opening Brackets
            if (ch == '(' || ch == '[' || ch == '{') {
                hasBrackets = true;
                stack.push(ch, i);
                steps.add(String.format("Step %d (Index %d): Found opening bracket '%c' -> PUSH onto stack. Current Stack: %s",
                        steps.size(), i, ch, stack.toStackString()));
            }
            // Handle Closing Brackets
            else if (ch == ')' || ch == ']' || ch == '}') {
                hasBrackets = true;
                if (stack.isEmpty()) {
                    String errorMsg = String.format("Unmatched closing bracket '%c' found at index %d with no preceding opening bracket.", ch, i);
                    steps.add("ERROR at index " + i + ": Encountered '" + ch + "' but the stack is empty! " + errorMsg);
                    return new ValidationResult(false, errorMsg, steps);
                }

                CharStackNode popped = stack.pop();
                char openChar = popped.data;

                if (!isMatchingPair(openChar, ch)) {
                    String errorMsg = String.format("Mismatched bracket at index %d: Expected closing counterpart for '%c' (from index %d), but found '%c'.",
                            i, openChar, popped.index, ch);
                    steps.add("ERROR at index " + i + ": Bracket mismatch! Popped '" + openChar + "' does not match '" + ch + "'. Current Stack: " + stack.toStackString());
                    return new ValidationResult(false, errorMsg, steps);
                } else {
                    steps.add(String.format("Step %d (Index %d): Found closing bracket '%c' -> POP matched '%c' from stack. Current Stack: %s",
                            steps.size(), i, ch, openChar, stack.toStackString()));
                }
            }
        }

        // Final check after scanning complete string
        if (!stack.isEmpty()) {
            CharStackNode remaining = stack.peek();
            String errorMsg = String.format("Missing closing bracket! Unclosed opening bracket '%c' remains (opened at index %d).",
                    remaining.data, remaining.index);
            steps.add("ERROR: End of formula reached, but stack still contains unclosed opening brackets: " + stack.toStackString());
            return new ValidationResult(false, errorMsg, steps);
        }

        if (!hasBrackets) {
            steps.add("No brackets detected in formula. Expression syntax is clean.");
            return new ValidationResult(true, "Expression is valid (contains no brackets).", steps);
        }

        steps.add("SUCCESS: All brackets matched and closed in proper order. Stack is completely empty.");
        return new ValidationResult(true, "Expression has valid and balanced brackets.", steps);
    }

    /**
     * Determines whether the given opening and closing brackets match.
     */
    private boolean isMatchingPair(char open, char close) {
        return (open == '(' && close == ')')
                || (open == '[' && close == ']')
                || (open == '{' && close == '}');
    }
}
