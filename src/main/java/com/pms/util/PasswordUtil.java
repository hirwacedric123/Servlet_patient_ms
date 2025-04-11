package com.pms.util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Utility class for password hashing and verification using BCrypt
 */
public class PasswordUtil {
    
    // Cost factor for BCrypt (higher = more secure but slower)
    private static final int BCRYPT_ROUNDS = 12;
    
    /**
     * Hashes a password using BCrypt
     * 
     * @param plainPassword the plain text password to hash
     * @return the hashed password
     */
    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(BCRYPT_ROUNDS));
    }
    
    /**
     * Verifies a plain text password against a hashed or plain text password
     * 
     * @param plainPassword the plain text password to check
     * @param storedPassword the password stored in the database (hashed or plain)
     * @return true if the password matches, false otherwise
     */
    public static boolean verifyPassword(String plainPassword, String storedPassword) {
        // Check if the stored password is a BCrypt hash (starts with $2a$)
        if (storedPassword != null && storedPassword.startsWith("$2a$")) {
            try {
                return BCrypt.checkpw(plainPassword, storedPassword);
            } catch (IllegalArgumentException e) {
                // Log the error but don't expose details in production
                System.err.println("Error verifying BCrypt password: " + e.getMessage());
                return false;
            }
        } else {
            // For non-BCrypt (plain text) passwords, do a direct comparison
            // This is for backward compatibility during transition
            return plainPassword != null && plainPassword.equals(storedPassword);
        }
    }
} 