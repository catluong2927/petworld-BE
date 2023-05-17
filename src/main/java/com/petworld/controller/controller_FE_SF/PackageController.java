package com.petworld.controller.controller_FE_SF;
import com.petworld.dto.packageDto.request.PackageDtoRequest;
import com.petworld.dto.packageDto.response.PackageDtoResponse;
import com.petworld.service.PackageService;
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
@RequestMapping("/api/packages")
@RequiredArgsConstructor
public class PackageController {
    private final PackageService packageService;

    @GetMapping("")
    public ResponseEntity<?> getAllPackages(@PageableDefault(size = 9) Pageable pageable) {
        Page<PackageDtoResponse> packageDtoResponses = packageService.findAll(pageable);
        if (packageDtoResponses.isEmpty()) return ResponseEntity.notFound().build();
        return ResponseEntity.ok().body(packageDtoResponses);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Optional<PackageDtoResponse>> getPackage(@PathVariable("id") Long id){
        Optional<PackageDtoResponse> servicePackage = packageService.getPackage(id);
        if(servicePackage.isEmpty()) return ResponseEntity.notFound().build();
        return ResponseEntity.ok().body(servicePackage);
    }

    @PostMapping("")
    public ResponseEntity<PackageDtoResponse> savePackages(@RequestBody PackageDtoRequest servicePackage){
        URI uri = URI.create(ServletUriComponentsBuilder.fromCurrentContextPath().path("api/packages").toUriString());
        return ResponseEntity.created(uri).body(packageService.savePackage(servicePackage));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Optional<PackageDtoResponse>> removePackage(@PathVariable("id") Long id){
        Optional<PackageDtoResponse> servicePackage = packageService.getPackage(id);
        if(servicePackage.isPresent()) {
            return ResponseEntity.notFound().build();
        } else {
            packageService.deleteByIdByStatus(id);
            return ResponseEntity.ok().body(servicePackage);
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updatePackage(@RequestBody PackageDtoRequest servicePackage){
        Optional<PackageDtoResponse> editedPackage = packageService.getPackage(servicePackage.getId());
        if(editedPackage.isEmpty()) {
            return ResponseEntity.notFound().build();
        } else {
            return ResponseEntity.ok().body(packageService.savePackage(servicePackage));
        }
    }

    @GetMapping("/search/{name}")
    public ResponseEntity<?> getAllPackageByName(@PathVariable("name") String name,Pageable pageable){
        Page<PackageDtoResponse> packageDtoResponses = packageService.getAllPackageByName(name,pageable);
        if (packageDtoResponses.isEmpty()) return ResponseEntity.notFound().build();
        return ResponseEntity.ok().body(packageDtoResponses);
    }
}
