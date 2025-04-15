package com.pms.util;

import java.util.HashMap;
import java.util.Map;

/**
 * Utility class for form validation.
 */
public class FormValidator {
    
    private Map<String, String> errors;
    
    public FormValidator() {
        this.errors = new HashMap<>();
    }
    
    /**
     * Validates that a required field is not null or empty.
     * 
     * @param fieldName The name of the field
     * @param fieldValue The value of the field
     * @param errorMessage The error message to display if validation fails
     * @return true if validation passes, false otherwise
     */
    public boolean validateRequired(String fieldName, String fieldValue, String errorMessage) {
        if (fieldValue == null || fieldValue.trim().isEmpty()) {
            errors.put(fieldName, errorMessage);
            return false;
        }
        return true;
    }
    
    /**
     * Validates that a field matches a regular expression pattern.
     * 
     * @param fieldName The name of the field
     * @param fieldValue The value of the field
     * @param pattern The regular expression pattern to match
     * @param errorMessage The error message to display if validation fails
     * @return true if validation passes, false otherwise
     */
    public boolean validatePattern(String fieldName, String fieldValue, String pattern, String errorMessage) {
        if (fieldValue != null && !fieldValue.matches(pattern)) {
            errors.put(fieldName, errorMessage);
            return false;
        }
        return true;
    }
    
    /**
     * Validates that a field's value is a valid email.
     * 
     * @param fieldName The name of the field
     * @param fieldValue The value of the field
     * @param errorMessage The error message to display if validation fails
     * @return true if validation passes, false otherwise
     */
    public boolean validateEmail(String fieldName, String fieldValue, String errorMessage) {
        String emailPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$";
        return validatePattern(fieldName, fieldValue, emailPattern, errorMessage);
    }
    
    /**
     * Validates that a field's value is a valid phone number.
     * 
     * @param fieldName The name of the field
     * @param fieldValue The value of the field
     * @param errorMessage The error message to display if validation fails
     * @return true if validation passes, false otherwise
     */
    public boolean validatePhone(String fieldName, String fieldValue, String errorMessage) {
        String phonePattern = "^\\d{10}$";  // Assuming 10-digit phone numbers
        return validatePattern(fieldName, fieldValue, phonePattern, errorMessage);
    }
    
    /**
     * Checks if there are any validation errors.
     * 
     * @return true if there are errors, false otherwise
     */
    public boolean hasErrors() {
        return !errors.isEmpty();
    }
    
    /**
     * Gets all validation errors.
     * 
     * @return A map of field names to error messages
     */
    public Map<String, String> getErrors() {
        return errors;
    }
    
    /**
     * Gets the error message for a specific field.
     * 
     * @param fieldName The name of the field
     * @return The error message, or null if there is no error for the field
     */
    public String getError(String fieldName) {
        return errors.get(fieldName);
    }
} 