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
import javax.servlet.ServletContext;

public class FileUploadUtil {
    private static final String UPLOAD_DIRECTORY = "patient_images";
    private static ServletContext servletContext;
    
    /**
     * Set the ServletContext for file operations
     * 
     * @param context The ServletContext
     */
    public static void setServletContext(ServletContext context) {
        servletContext = context;
    }
    
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
        
        // Try multiple potential upload paths
        String realPath = null;
        File uploadDir = null;
        
        // First attempt: Try using the servlet context's real path if available
        if (servletContext != null) {
            realPath = servletContext.getRealPath("/" + UPLOAD_DIRECTORY);
            System.out.println("Trying servlet context real path: " + realPath);
            if (realPath != null) {
                uploadDir = new File(realPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                if (uploadDir.exists() && uploadDir.canWrite()) {
                    System.out.println("Using servlet context real path for upload: " + realPath);
                } else {
                    uploadDir = null; // Reset for next attempt
                }
            }
        }
        
        // Second attempt: Try using the catalina base webapps directory
        if (uploadDir == null) {
            String catalinaBase = System.getProperty("catalina.base");
            System.out.println("Catalina base: " + catalinaBase);
            
            if (catalinaBase != null) {
                realPath = catalinaBase + File.separator + "webapps" + File.separator + UPLOAD_DIRECTORY;
                System.out.println("Trying catalina webapps path: " + realPath);
                uploadDir = new File(realPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                if (uploadDir.exists() && uploadDir.canWrite()) {
                    System.out.println("Using catalina webapps path for upload: " + realPath);
                } else {
                    uploadDir = null; // Reset for next attempt
                }
            }
        }
        
        // Third attempt: Try using the ROOT webapp directory
        if (uploadDir == null) {
            String catalinaBase = System.getProperty("catalina.base");
            if (catalinaBase != null) {
                realPath = catalinaBase + File.separator + "webapps" + File.separator + "ROOT" + 
                          File.separator + UPLOAD_DIRECTORY;
                System.out.println("Trying ROOT webapp path: " + realPath);
                uploadDir = new File(realPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                if (uploadDir.exists() && uploadDir.canWrite()) {
                    System.out.println("Using ROOT webapp path for upload: " + realPath);
                } else {
                    uploadDir = null; // Reset for next attempt
                }
            }
        }
        
        // Fourth attempt: Try using the user's temp directory
        if (uploadDir == null) {
            realPath = System.getProperty("java.io.tmpdir") + File.separator + UPLOAD_DIRECTORY;
            System.out.println("Trying temp directory path: " + realPath);
            uploadDir = new File(realPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            if (uploadDir.exists() && uploadDir.canWrite()) {
                System.out.println("Using temp directory for upload: " + realPath);
            } else {
                throw new IOException("Failed to create writable upload directory in any location");
            }
        }
        
        // Save the file
        try (InputStream input = part.getInputStream()) {
            Path filePath = Paths.get(realPath, fileName);
            Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);
            System.out.println("File saved successfully at: " + filePath);
            
            // Return the image path
            return "/patient_images/" + fileName;
        }
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
        
        // Remove leading slash if present
        if (relativePath.startsWith("/")) {
            relativePath = relativePath.substring(1);
        }
        
        // Try multiple locations
        boolean deleted = false;
        
        // Try servlet context real path
        if (servletContext != null) {
            String realPath = servletContext.getRealPath("/" + relativePath);
            if (realPath != null) {
                try {
                    Path filePath = Paths.get(realPath);
                    deleted = Files.deleteIfExists(filePath);
                    if (deleted) {
                        return true;
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        
        // Try catalina base
        String catalinaBase = System.getProperty("catalina.base");
        if (catalinaBase != null) {
            try {
                Path filePath = Paths.get(catalinaBase, "webapps", relativePath);
                deleted = Files.deleteIfExists(filePath);
                if (deleted) {
                    return true;
                }
                
                // Try ROOT webapp
                filePath = Paths.get(catalinaBase, "webapps", "ROOT", relativePath);
                deleted = Files.deleteIfExists(filePath);
                if (deleted) {
                    return true;
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        
        // Try temp directory
        try {
            Path filePath = Paths.get(System.getProperty("java.io.tmpdir"), relativePath);
            return Files.deleteIfExists(filePath);
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }
} 