package com.petworld.service.impl;

import com.petworld.converter.CartConverter;
import com.petworld.domain.Cart;
import com.petworld.domain.CartDetail;
import com.petworld.domain.Product;
import com.petworld.dto.cartDto.request.CartDetailDtoRequest;
import com.petworld.dto.cartDto.response.CartDtoResponse;
import com.petworld.repository.ProductRepository;
import com.petworld.repository.CartDetailRepository;
import com.petworld.repository.CartRepository;
import com.petworld.repository.UserRepository;
import com.petworld.service.ICartService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CartServiceImpl implements ICartService {

    private final CartRepository cartRepository;
    private final CartConverter cartConverter;

    //Add to cart
    private final CartDetailRepository cartDetailRepository;
    private final ProductRepository productRepository;


    @Override
    public Page<CartDtoResponse> getAllCarts(Pageable pageable) {
        Page<Cart> carts = cartRepository.findAll(pageable);
        Page<CartDtoResponse> classroomDtos = cartConverter.entitiesToDtos(carts);
        return classroomDtos;
    }

    @Override
    public CartDtoResponse getCartByEmail(String email) {
        Cart cart = cartRepository.findCartByEmail(email);
        if(cart != null){
            CartDtoResponse cartDtoResponse = cartConverter.entityToDto(cart);
            if(cartDtoResponse != null)
                return cartDtoResponse;
            return null;
        }
        return null;
    }

    public void addToCart(String email, CartDetailDtoRequest cartDetailDtoRequest) {
        //Lấy giỏ hàng cho khách hàng
        Long cartId = cartRepository.findCartByEmail(email).getId();

        Cart cart = cartRepository.findById(cartId).orElse(null);
        Product product = productRepository.findById(cartDetailDtoRequest.getProductId()).orElse(null);

        List<CartDetail> cartDetailList = cart.getCartDetailList();

        boolean isProductExist = false;

        //Kiểm tra xem trong giỏ hàng có sản phẩm này chưa. Nếu có thì tăng số lượng và giá.
        for (CartDetail cartDetail : cartDetailList) {
            if (cartDetail.getProduct().getId().equals(cartDetailDtoRequest.getProductId())) {
                cartDetail.setAmount(cartDetailDtoRequest.getAmount());
                cartDetail.setTotalPrice(cartDetailDtoRequest.getTotalPrice());
                cartDetailRepository.save(cartDetail);
                isProductExist = true;
                break;
            }
        }

        //Ngược lại
        if (!isProductExist) {
            CartDetail cartDetail = new CartDetail();
            cartDetail.setProduct(product);
            cartDetail.setAmount(cartDetailDtoRequest.getAmount());
            cartDetail.setTotalPrice(cartDetailDtoRequest.getTotalPrice());
            cartDetail.setCart(cart);
            cartDetail.setStatus(false);
            cartDetailRepository.save(cartDetail);
            cartDetailList.add(cartDetail);
        }

        //Tổng số lượng và tổng chi phí
        Double totalPayment = 0.0;
        Integer amountItem = 0;

        if(!cartDetailList.isEmpty()) {
            for (CartDetail cartDetail : cartDetailList) {
                //Cái nào được chọn sẽ lấy
//                if (cartDetail.getStatus()) {
//                    totalPayment += cartDetail.getTotalPrice();
//                    amountItem += cartDetail.getAmount();
//                }
                totalPayment += cartDetail.getTotalPrice();
                amountItem += cartDetail.getAmount();
            }
        }

        cart.setTotalPayment(totalPayment);
        cart.setAmountItem(amountItem);
        cartRepository.save(cart);
    }

    //Xóa cartDetail
    @Override
    public void removeToCart (String email, Long productId){
        //Lấy giỏ hàng cho khách hàng
        Long cartId = cartRepository.findCartByEmail(email).getId();
        Cart cart = cartRepository.findById(cartId).orElse(null);

        List<CartDetail> cartDetailList = cart.getCartDetailList();
        CartDetail cartDetail = getCartDetail(cartDetailList, productId);

        cart.setTotalPayment(cart.getTotalPayment() - cartDetail.getTotalPrice());
        cart.setAmountItem(cart.getAmountItem() - cartDetail.getAmount());

        //Xóa cartDetail trong danh sách
        cartDetailList.remove(cartDetail);

        //Xóa cartDetail trong database
        cartDetailRepository.delete(cartDetail);

        //Lưu cart
        cartRepository.save(cart);
    }

    public CartDetail getCartDetail (List<CartDetail> cartDetailList, Long productId){
        if(!cartDetailList.isEmpty()){
            for(CartDetail cartDetail: cartDetailList){
                if(cartDetail.getProduct().getId().equals(productId)){
                    return cartDetail;
                }
            }
        }
        return null;
    }
}
