package com.petworld.controller.controller_FE_SE;
import com.petworld.domain.Service;
import com.petworld.dto.servicePackageDto.request.ServicePackageDtoRequest;
import com.petworld.dto.servicePackageDto.response.ServicePackageDtoResponse;
import com.petworld.service.ServicePackageService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.Collection;
import java.util.List;
import java.util.Optional;


@RestController
@CrossOrigin("*")
@RequestMapping("/api/service-packages")
@RequiredArgsConstructor
public class PackageServiceController {
    private final ServicePackageService servicePackageService;

    @GetMapping("/{id}")
    public ResponseEntity<Optional<ServicePackageDtoResponse>> getServicePackage(@PathVariable("id") Long id){
        return ResponseEntity.ok().body(servicePackageService.getServicePackage(id));
    }

    @PostMapping("")
    public ResponseEntity<ServicePackageDtoResponse> saveServicePackages(@RequestBody ServicePackageDtoRequest servicePackage){
        URI uri = URI.create(ServletUriComponentsBuilder.fromCurrentContextPath().path("api/service_package").toUriString());
        return ResponseEntity.created(uri).body(servicePackageService.saveServicePackage(servicePackage));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Optional<ServicePackageDtoResponse>> removeServicePackage(@PathVariable("id") Long id){
            Optional<ServicePackageDtoResponse> servicePackage = servicePackageService.getServicePackage(id);
            if(servicePackage.isPresent()) {
                return ResponseEntity.notFound().build();
            } else {
                servicePackageService.deleteByIdByStatus(id);
                return ResponseEntity.ok().body(servicePackage);
            }
    }

    @PutMapping("/{id}")
    public ResponseEntity<Optional<ServicePackageDtoResponse>> updateServicePackage(@PathVariable("id") Long id,
                                                                                    @RequestBody ServicePackageDtoRequest servicePackage){
            Optional<ServicePackageDtoResponse> editedServicePackage = servicePackageService.getServicePackage(id);
            if(!editedServicePackage.isPresent()) {
                return ResponseEntity.notFound().build();
            } else {
                URI uri = URI.create(ServletUriComponentsBuilder.fromCurrentContextPath()
                        .path("api/service-packages").toUriString());
                return ResponseEntity.created(uri).body(Optional.ofNullable(
                        servicePackageService.saveServicePackage(servicePackage)));
            }
    }

    @GetMapping("/search/{name}")
    public ResponseEntity<Collection<ServicePackageDtoResponse>> getAllServicePackageByName(@PathVariable("name") String name){
        return ResponseEntity.ok().body(servicePackageService.getAllServicePackageByName(name));
    }

    @GetMapping()
    public ResponseEntity<List<ServicePackageDtoResponse>> getAllServicePackages(
            @RequestParam(defaultValue = "0") int pageNumber,
            @RequestParam(defaultValue = "10") int pageSize,
            @RequestParam(defaultValue = "asc") String sortDirection,
            @RequestParam(defaultValue = "maxPrice") String sortField) {

        Sort sort = sortDirection.equalsIgnoreCase("desc") ? Sort.by(sortField).descending() : Sort.by(sortField).ascending();
        Pageable pageable = PageRequest.of(pageNumber, pageSize, sort);

        Page<ServicePackageDtoResponse> servicePackageDtoResponses = servicePackageService.findAll(pageable);

        HttpHeaders headers = new HttpHeaders();
        headers.add("X-Total-Count", String.valueOf(servicePackageDtoResponses.getTotalElements()));

        return ResponseEntity.ok().headers(headers).body(servicePackageDtoResponses.getContent());
    }
}
