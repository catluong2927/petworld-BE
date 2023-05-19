package com.petworld.dto.order;

import com.petworld.dto.userDto.response.UserDtoResponse;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderDtoResponse {
    private Long id;
    private String itemName;
    private Date date;

    private Double total;

    private String status;
    private String address;

    private UserDtoResponse user;
}
