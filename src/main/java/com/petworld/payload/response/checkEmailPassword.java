package com.petworld.payload.response;

import lombok.Data;

@Data
public class checkEmailPassword {
    private String email;
    private String userName;
}
