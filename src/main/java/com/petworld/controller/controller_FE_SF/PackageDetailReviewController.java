package com.petworld.controller.controller_FE_SF;

import com.petworld.dto.packageDetailReviewDto.request.PackageDetailReviewDtoRequest;
import com.petworld.dto.packageDetailReviewDto.response.PackageDetailReviewDtoResponse;
import com.petworld.service.PackageDetailReviewService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.Optional;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/package-detail-reviews")
@RequiredArgsConstructor
public class PackageDetailReviewController {
    private final PackageDetailReviewService packageDetailReviewService;

    @GetMapping("")
    public ResponseEntity<?> getAllPackageDetailReviews(@PageableDefault(size = 9) Pageable pageable) {
        Page<PackageDetailReviewDtoResponse> packageDetailReviewDtoResponses = packageDetailReviewService.findAll(pageable);
        if (packageDetailReviewDtoResponses.isEmpty()) return ResponseEntity.notFound().build();
        return ResponseEntity.ok().body(packageDetailReviewDtoResponses);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getPackageDetailReviewById(@PathVariable("id") Long id){
        Optional<PackageDetailReviewDtoResponse> packageReviewDtoResponse = packageDetailReviewService.getPackDetailReviewById(id);
        if(packageReviewDtoResponse.isEmpty()) return ResponseEntity.notFound().build();
        return ResponseEntity.ok().body(packageReviewDtoResponse);
    }

    @PostMapping("")
    public ResponseEntity<?> savePackageReviews(@RequestBody PackageDetailReviewDtoRequest packageDetailReviewDtoRequest){
        URI uri = URI.create(ServletUriComponentsBuilder.fromCurrentContextPath().path("api/package-reviews").toUriString());
        packageDetailReviewService.savePackageDetailReview(packageDetailReviewDtoRequest);
        return ResponseEntity.created(uri).body(packageDetailReviewDtoRequest);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> removePackageReview(@PathVariable("id") Long id){
        Optional<PackageDetailReviewDtoResponse> packageReview = packageDetailReviewService.getPackDetailReviewById(id);
        if(packageReview.isPresent()) {
            return ResponseEntity.notFound().build();
        } else {
            packageDetailReviewService.deleteByIdByStatus(id);
            return ResponseEntity.ok().body(packageReview);
        }
    }

    @GetMapping("/package-detail/{id}")
    public ResponseEntity<?> getPackReviewByPackageId(@PathVariable Long id,Pageable pageable){
        Page<PackageDetailReviewDtoResponse> packageReviewDtoResponses = packageDetailReviewService.findPackageDetailReviewsByPackageDetail(id,pageable);
        if (packageReviewDtoResponses.isEmpty()) return ResponseEntity.notFound().build();
        return ResponseEntity.ok().body(packageReviewDtoResponses);
    }
}
