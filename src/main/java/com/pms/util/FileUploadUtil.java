package com.pms.util;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

import javax.servlet.http.Part;

public class FileUploadUtil {
    private static final String UPLOAD_DIRECTORY = "patient_images";
    
    /**
     * Saves an uploaded file to the server's file system
     * 
     * @param part The Part object containing the uploaded file
     * @return The relative path to the saved file, which can be stored in the database
     * @throws IOException If an error occurs during file saving
     */
    public static String saveFile(Part part) throws IOException {
        // Ensure that the file is actually an image
        String contentType = part.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            throw new IOException("Only image files are allowed");
        }
        
        // Generate a unique file name to prevent collisions
        String fileName = UUID.randomUUID().toString() + getFileExtension(part);
        
        // Create the upload directory if it doesn't exist
        String applicationPath = getApplicationPath();
        String uploadPath = applicationPath + File.separator + UPLOAD_DIRECTORY;
        
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        
        // Save the file
        try (InputStream input = part.getInputStream()) {
            Path filePath = Paths.get(uploadPath, fileName);
            Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);
            
            // Return the relative path to the file (to be stored in the database)
            return UPLOAD_DIRECTORY + "/" + fileName;
        }
    }
    
    /**
     * Gets the application's absolute path for file operations
     * 
     * @return The application's absolute path
     */
    private static String getApplicationPath() {
        // Get the absolute path to the application
        return System.getProperty("catalina.base") + File.separator + "webapps";
    }
    
    /**
     * Extracts the file extension from the Part
     * 
     * @param part The Part containing the file
     * @return The file extension (e.g., ".jpg", ".png")
     */
    private static String getFileExtension(Part part) {
        String submittedFileName = part.getSubmittedFileName();
        if (submittedFileName == null || submittedFileName.isEmpty()) {
            return ".jpg"; // Default extension
        }
        
        int dotIndex = submittedFileName.lastIndexOf(".");
        if (dotIndex < 0) {
            return ".jpg"; // Default extension if no extension found
        }
        
        return submittedFileName.substring(dotIndex);
    }
    
    /**
     * Deletes a file at the given relative path
     * 
     * @param relativePath The relative path to the file to be deleted
     * @return true if the file was successfully deleted, false otherwise
     */
    public static boolean deleteFile(String relativePath) {
        if (relativePath == null || relativePath.isEmpty()) {
            return false;
        }
        
        String applicationPath = getApplicationPath();
        Path filePath = Paths.get(applicationPath, relativePath);
        
        try {
            return Files.deleteIfExists(filePath);
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }
} 