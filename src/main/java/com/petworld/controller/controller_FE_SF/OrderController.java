package com.petworld.controller.controller_FE_SF;

import com.petworld.dto.order.OrderDetailDtoRequest;
import com.petworld.dto.order.OrdersDtoRequest;
import com.petworld.service.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/orders")
public class OrderController {
    private final OrderService orderService;

    @GetMapping("/{email}")
    public ResponseEntity<?> getOrderByEmail(@PathVariable("email") String email) {
        return new ResponseEntity<>(orderService.findOrderByEmail(email), HttpStatus.OK);
    };
    @PostMapping("")
    public ResponseEntity<?> addToCart(@RequestBody OrdersDtoRequest ordersDtoRequest){
        return new ResponseEntity<>(orderService.saveOrder(ordersDtoRequest), HttpStatus.CREATED);
    }

}
