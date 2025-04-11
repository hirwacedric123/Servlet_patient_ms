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
     * Verifies a plain text password against a hashed password
     * 
     * @param plainPassword the plain text password to check
     * @param hashedPassword the hashed password to check against
     * @return true if the password matches, false otherwise
     */
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }
} 