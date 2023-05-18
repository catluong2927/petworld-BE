package com.petworld.dto.order;

import com.petworld.dto.userDto.response.UserDtoResponse;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.sql.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderDtoResponse {
    private Long id;
    private Date date;

    private Double total;

    private String status;

    private UserDtoResponse user;
}
