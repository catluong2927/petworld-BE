package com.petworld.controller.controller_FE_BO;

import com.petworld.dto.imagedetailDto.request.UpdateImageDetailDto;
import com.petworld.dto.imagedetailDto.response.ImageDetailsDto;
import com.petworld.dto.productDto.request.UpdateProductDtoRequest;
import com.petworld.dto.productDto.response.ProductDetailDtoResponse;
import com.petworld.service.ImageDetailService;
import com.petworld.service.SecurityService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin("*")
@RestController
@RequestMapping("/api/image-detail")
@RequiredArgsConstructor
public class ImageDetailControllerBo {
    private final SecurityService securityService;
    private final ImageDetailService imageDetailService;

    @GetMapping("/{id}")
    public ResponseEntity<?> findImageDetailById(@PathVariable("id") Long id,
                                                 @RequestHeader("Authorization") final String authToken) {
        if (!securityService.isAuthenticated() && !securityService.isValidToken(authToken)) {
            return new ResponseEntity<String>("Responding with unauthorized error. Message - {}", HttpStatus.UNAUTHORIZED);
        }
        List<ImageDetailsDto> imageDetailsDtos = imageDetailService.findImageDetailById(id);
        if(!imageDetailsDtos.isEmpty()) {
            return new ResponseEntity<>(imageDetailsDtos, HttpStatus.OK);
        }
        return new ResponseEntity<>("Not find", HttpStatus.BAD_REQUEST);
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateImageDetaailById(@PathVariable("id") Long id,
                                                    @RequestBody List<UpdateImageDetailDto> updateImageDetailDtos,
                                                    @RequestHeader("Authorization") final String authToken) {
        if (!securityService.isAuthenticated() && !securityService.isValidToken(authToken)) {
            return new ResponseEntity<String>("Responding with unauthorized error. Message - {}", HttpStatus.UNAUTHORIZED);
        }
        if(imageDetailService.updateImageDetail(id,updateImageDetailDtos)) {
            return new ResponseEntity<>("Update successfully", HttpStatus.OK);
        }
        return new ResponseEntity<>("Update failed", HttpStatus.BAD_REQUEST);
    }
}
