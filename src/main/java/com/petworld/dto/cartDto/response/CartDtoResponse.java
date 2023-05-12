package com.petworld.dto.cartDto.response;

import lombok.*;

import java.sql.Date;
import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class CartDtoResponse {
    private Long id;
    private List<CartDetailDtoResponse> cartDetailDtoResponses;
    private Integer amountItem;
    private Double totalPayment;
    private Date cartDate;

    private Long userId;

    public Integer getAmountItem() {
        return this.getCartDetailDtoResponses().size();
    }

    public Double getTotalPayment() {
        Double total_Payment = 0.0;
        for (CartDetailDtoResponse cartDetailDtoResponse: cartDetailDtoResponses) {
            total_Payment += cartDetailDtoResponse.getTotalPrice();
        }
        return total_Payment;
    }
}
