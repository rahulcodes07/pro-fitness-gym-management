package com.profitness.dsa;

import java.util.List;

/**
 * Result data carrier for mathematical and bracket expression validation.
 * <p>
 * Holds the validation outcome (valid/invalid), an informative diagnostic message,
 * and an ordered list of step-by-step push/pop operations for front-end visualization.
 * </p>
 */
public class ValidationResult {
    private boolean valid;
    private String message;
    private List<String> steps;

    /**
     * Constructs a ValidationResult with outcome, message, and execution steps.
     *
     * @param valid   true if expression has balanced and properly ordered brackets
     * @param message diagnostic explanation of the result
     * @param steps   detailed step-by-step trace of stack push and pop operations
     */
    public ValidationResult(boolean valid, String message, List<String> steps) {
        this.valid = valid;
        this.message = message;
        this.steps = steps;
    }

    public boolean isValid() {
        return valid;
    }

    public void setValid(boolean valid) {
        this.valid = valid;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public List<String> getSteps() {
        return steps;
    }

    public void setSteps(List<String> steps) {
        this.steps = steps;
    }

    @Override
    public String toString() {
        return "ValidationResult{" +
                "valid=" + valid +
                ", message='" + message + '\'' +
                ", stepsCount=" + (steps != null ? steps.size() : 0) +
                '}';
    }
}
