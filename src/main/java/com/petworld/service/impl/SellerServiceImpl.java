package com.petworld.service.impl;

import com.petworld.converter.SellerConverter;
import com.petworld.entity.Center;
import com.petworld.entity.Seller;
import com.petworld.dto.sellerDto.request.SellerDtoRequest;
import com.petworld.dto.sellerDto.response.SellerDtoResponse;
import com.petworld.repository.CenterRepository;
import com.petworld.repository.SellerRepository;
import com.petworld.service.SellerService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
@Transactional
public class SellerServiceImpl implements SellerService {
    private final SellerRepository sellerRepository;
    private final SellerConverter sellerConverter;
    private final CenterRepository centerRepository;
    @Override
    public Optional<SellerDtoResponse> getById(Long id) {
        SellerDtoResponse seller = sellerConverter.entityToDto(sellerRepository.getById(id));
        return Optional.ofNullable(seller);
    }

    @Override
    public Optional<Page<SellerDtoResponse>> findAll(Pageable pageable) {
        Page<Seller> sellers = sellerRepository.findAll(pageable);
        return Optional.ofNullable(sellers.map(sellerConverter::entityToDto));
    }

    @Override
    public Optional<SellerDtoResponse> deleteByIdByStatus(Long id) {
        sellerRepository.deleteByIdSeller(id);
        return Optional.ofNullable(sellerConverter.entityToDto(sellerRepository.getById(id)));
    }

    @Override
    public Optional<SellerDtoResponse> save(SellerDtoRequest sellerDtoRequest) {
        Seller seller = sellerConverter.dtoToEntity(sellerDtoRequest);
        Center center = centerRepository.findCenterByUserEmail(sellerDtoRequest.getUserEmail());
        seller.setCenter(center);
        sellerRepository.save(seller);
        return Optional.ofNullable(sellerConverter.entityToDto(seller));
    }


    @Override
    public List<SellerDtoResponse> findSellersByCenterUserEmail(String email) {
       List<Seller> sellers = sellerRepository.findSellersByCenterUserEmail(email);
       List<SellerDtoResponse> sellerDtoResponses = new ArrayList<>();
       sellers.forEach(element -> sellerDtoResponses.add(sellerConverter.entityToDto(element))
       );
        return sellerDtoResponses;
    }
}
