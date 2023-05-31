package com.petworld.service.impl;
import com.petworld.entity.*;
import com.petworld.dto.cartDto.response.CartDetailDtoResponse;
import com.petworld.dto.cartDto.request.CartDetailDtoRequest;
import com.petworld.entity.Package;
import com.petworld.repository.*;
import com.petworld.service.CartService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CartServiceImpl implements CartService {
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final ProductRepository productRepository;
    private final PackageDetailRepository packageDetailRepository;
    private final PackageRepository packageRepository;

    @Override
    public List<CartDetailDtoResponse> getCartByEmail(String email) {
        Long cartId = cartRepository.findCartByUserEmail(email).getId();
        List<CartDetail> cartDetailList = cartDetailRepository.findCartDetailByCartId(cartId);
        List<CartDetailDtoResponse> cartDetailDtos = new ArrayList<>();

        cartDetailList.forEach(element -> {
            if(element.getType()) {
                Product product = productRepository.getById(element.getTypeId());
                CartDetailDtoResponse cartDetailDto = new CartDetailDtoResponse();
                cartDetailDto.setId(element.getId());
                cartDetailDto.setType(true);
                Double price = product.getPrice()- ((product.getSale() * product.getPrice())/ 100);
                cartDetailDto.setPrice(price);
                cartDetailDto.setOriginalPrice(product.getPrice());
                cartDetailDto.setName(product.getName());
                cartDetailDto.setAmount(element.getAmount());
                cartDetailDto.setImage(product.getImage());
                cartDetailDto.setTypeId(product.getId());
                cartDetailDto.setTotalPrice(element.getTotalPrice());
                cartDetailDtos.add(cartDetailDto);
            }
            else {
                PackageDetail packageDetail = packageDetailRepository.getById(element.getTypeId());
                CartDetailDtoResponse cartDetailDto = new CartDetailDtoResponse();
                cartDetailDto.setId(element.getId());
                cartDetailDto.setType(false);
                cartDetailDto.setName(packageDetail.getServicePackage().getName());
                cartDetailDto.setOriginalPrice(packageDetail.getPrice());
                cartDetailDto.setPrice(packageDetail.getPrice());
                cartDetailDto.setAmount(element.getAmount());
                cartDetailDto.setImage(packageDetail.getImage());
                cartDetailDto.setTypeId(packageDetail.getId());
                cartDetailDto.setTotalPrice(element.getTotalPrice());
                cartDetailDtos.add(cartDetailDto);
            };
        });
        return cartDetailDtos;
    }

    @Override
    public void addToCart( CartDetailDtoRequest cartDetailDtoRequest) {
        Cart cart = cartRepository.findCartByUserEmail(cartDetailDtoRequest.getUserEmail());
        Long typeId = cartDetailDtoRequest.getTypeId();
        Boolean type = cartDetailDtoRequest.getType();
        Integer amount = cartDetailDtoRequest.getAmount();
        Double totalPrice = cartDetailDtoRequest.getTotalPrice();
        CartDetail cartDetail = new CartDetail();
        BeanUtils.copyProperties(cartDetailDtoRequest, cartDetail);
        Optional<CartDetail> existingCartDetail = cartDetailRepository.findCartDetailByTypeIdAndCartIdAndType(typeId,cart.getId(), type);
        if(existingCartDetail.isPresent() ){
            existingCartDetail.get().setAmount(existingCartDetail.get().getAmount() + amount);
            existingCartDetail.get().setTotalPrice(existingCartDetail.get().getTotalPrice() + totalPrice);
            cartDetailRepository.save(existingCartDetail.get());
        } else {
            cartDetail.setCart(cart);
            cartDetailRepository.save(cartDetail);
        }
    }

    @Override
    public void removeToCart(CartDetailDtoRequest cartDetailDtoRequest) {
        Cart cart = cartRepository.findCartByUserEmail(cartDetailDtoRequest.getUserEmail());
        Long typeId = cartDetailDtoRequest.getTypeId();
        Boolean type = cartDetailDtoRequest.getType();
        Integer amount = cartDetailDtoRequest.getAmount();
        Double totalPrice = cartDetailDtoRequest.getTotalPrice();
        Optional<CartDetail> existingCartDetail = cartDetailRepository.findCartDetailByTypeIdAndCartIdAndType(typeId,cart.getId(), type);
        if(existingCartDetail.isPresent() ){
            if(existingCartDetail.get().getAmount() > amount){
                existingCartDetail.get().setAmount(existingCartDetail.get().getAmount() - amount);
                existingCartDetail.get().setTotalPrice(existingCartDetail.get().getTotalPrice() - totalPrice);
                cartDetailRepository.save(existingCartDetail.get());
            } else {
                cartDetailRepository.deleteById(existingCartDetail.get().getId());
            }
        }
    }

    @Override
    public void deleteAllItemsInCart(List<Long> cartDetailIds) {
        cartDetailIds.forEach(id -> {
            cartDetailRepository.deleteById(id);
        });
    };
}
