package com.petworld.service;

public interface SecurityService {
    boolean isAuthenticated();
    boolean isValidToken(String token);
}
