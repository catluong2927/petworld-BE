package com.petworld.controller.controller_FE_SE;

import com.petworld.dto.packageReviewDto.request.PackageReviewDtoRequest;
import com.petworld.dto.packageReviewDto.response.PackageReviewDtoResponse;
import com.petworld.service.PackageReviewService;
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
@RequestMapping("/api/package-reviews")
@RequiredArgsConstructor
public class PackageReviewController {
    private final PackageReviewService packageReviewService;

    @GetMapping("")
    public ResponseEntity<?> getAllPackageReviews(@PageableDefault(size = 9) Pageable pageable) {
        Page<PackageReviewDtoResponse> packageReviewDtoResponses = packageReviewService.findAll(pageable);
        if (packageReviewDtoResponses.isEmpty()) return ResponseEntity.notFound().build();
        return ResponseEntity.ok().body(packageReviewDtoResponses);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Optional<PackageReviewDtoResponse>> getPackage(@PathVariable("id") Long id){
        Optional<PackageReviewDtoResponse> packageReviewDtoResponse = packageReviewService.getPackReview(id);
        if(packageReviewDtoResponse.isEmpty()) return ResponseEntity.notFound().build();
        return ResponseEntity.ok().body(packageReviewDtoResponse);
    }

    @PostMapping("")
    public ResponseEntity<?> savePackageReviews(@RequestBody PackageReviewDtoRequest packageReviewDtoRequest){
        URI uri = URI.create(ServletUriComponentsBuilder.fromCurrentContextPath().path("api/package-reviews").toUriString());
        return ResponseEntity.created(uri).body(packageReviewService.savePackageReview(packageReviewDtoRequest));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> removePackageReview(@PathVariable("id") Long id){
        Optional<PackageReviewDtoResponse> packageReview = packageReviewService.getPackReview(id);
        if(packageReview.isPresent()) {
            return ResponseEntity.notFound().build();
        } else {
            packageReviewService.deleteByIdByStatus(id);
            return ResponseEntity.ok().body(packageReview);
        }
    }

    @GetMapping("/package/{id}")
    public ResponseEntity<?> getPackReviewByPackageId(@PathVariable Long id,Pageable pageable){
        Page<PackageReviewDtoResponse> packageReviewDtoResponses = packageReviewService.findPackageReviewsByPackage(id,pageable);
        if (packageReviewDtoResponses.isEmpty()) return ResponseEntity.notFound().build();
        return ResponseEntity.ok().body(packageReviewDtoResponses);
    }
}
