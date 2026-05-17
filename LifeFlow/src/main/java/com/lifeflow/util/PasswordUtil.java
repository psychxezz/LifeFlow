package com.lifeflow.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

/**
 * Utility class for hashing and verifying passwords.
 *
 * <p>Passwords are stored in the format: {@code <hex-salt>:<hex-hash>}
 * using SHA-256 with a 16-byte random salt. No external library is required
 * since {@link MessageDigest} is part of the Java standard library.
 */
public class PasswordUtil {

    private static final String ALGORITHM = "SHA-256";
    private static final int SALT_BYTES = 16;

    private PasswordUtil() {
        // Utility class — no instantiation
    }

    /**
     * Hashes a plain-text password using SHA-256 with a randomly generated salt.
     *
     * @param plainPassword the raw password to hash
     * @return a string in the form {@code <hex-salt>:<hex-hash>}
     */
    public static String hashPassword(String plainPassword) {
        byte[] salt = generateSalt();
        byte[] hash = sha256(salt, plainPassword);
        return toHex(salt) + ":" + toHex(hash);
    }

    /**
     * Verifies a plain-text password against a previously stored hash.
     *
     * @param plainPassword  the raw password to check
     * @param storedPassword the value previously produced by {@link #hashPassword(String)}
     * @return {@code true} if the password matches, {@code false} otherwise
     */
    public static boolean verifyPassword(String plainPassword, String storedPassword) {
        if (storedPassword == null || !storedPassword.contains(":")) {
            return false;
        }
        String[] parts = storedPassword.split(":", 2);
        byte[] salt = fromHex(parts[0]);
        byte[] expectedHash = fromHex(parts[1]);
        byte[] actualHash = sha256(salt, plainPassword);
        return MessageDigest.isEqual(expectedHash, actualHash);
    }

    // -----------------------------------------------------------------------
    // Private helpers
    // -----------------------------------------------------------------------

    private static byte[] generateSalt() {
        byte[] salt = new byte[SALT_BYTES];
        new SecureRandom().nextBytes(salt);
        return salt;
    }

    private static byte[] sha256(byte[] salt, String password) {
        try {
            MessageDigest md = MessageDigest.getInstance(ALGORITHM);
            md.update(salt);
            md.update(password.getBytes(java.nio.charset.StandardCharsets.UTF_8));
            return md.digest();
        } catch (NoSuchAlgorithmException e) {
            // SHA-256 is guaranteed to be present in every JVM
            throw new RuntimeException("SHA-256 algorithm not available", e);
        }
    }

    private static String toHex(byte[] bytes) {
        StringBuilder sb = new StringBuilder(bytes.length * 2);
        for (byte b : bytes) {
            sb.append(String.format("%02x", b & 0xff));
        }
        return sb.toString();
    }

    private static byte[] fromHex(String hex) {
        int len = hex.length();
        byte[] bytes = new byte[len / 2];
        for (int i = 0; i < len; i += 2) {
            bytes[i / 2] = (byte) Integer.parseInt(hex.substring(i, i + 2), 16);
        }
        return bytes;
    }
}
