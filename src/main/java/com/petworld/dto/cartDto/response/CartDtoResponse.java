package com.petworld.dto.cartDto.response;

import lombok.*;

import java.sql.Date;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Data
public class CartDtoResponse {
    private Long id;
    private List<CartDetailDtoResponse> cartDetailDtoResponses;
    private Double totalPayment;
    private Integer amountItem;
    private Date cartDate;

    private Integer customerId;

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
