package com.petworld.controller.controller_FE_SE;

import com.petworld.domain.ServicePackage;
import com.petworld.service.ServicePackageService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.Collection;
import java.util.Optional;


@RestController
@RequestMapping("/api/service-packages")
@RequiredArgsConstructor
public class PackageServiceController {
    private final ServicePackageService servicePackageService;

    @GetMapping("")
    public ResponseEntity<Collection<ServicePackage>> getAllServicePackages(){
        return ResponseEntity.ok().body(servicePackageService.getAllServicePackages());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Optional<ServicePackage>> getServicePackage(@PathVariable("id") Long id){
        return ResponseEntity.ok().body(servicePackageService.getServicePackage(id));
    }

    @PostMapping("")
    public ResponseEntity<ServicePackage> saveServicePackages(@RequestBody ServicePackage servicePackage){
        URI uri = URI.create(ServletUriComponentsBuilder.fromCurrentContextPath().path("api/service_package").toUriString());
        return ResponseEntity.created(uri).body(servicePackageService.saveServicePackage(servicePackage));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Optional<ServicePackage>> removeServicePackage(@PathVariable("id") Long id){
            Optional<ServicePackage> servicePackage = servicePackageService.getServicePackage(id);
            if(servicePackage == null) {
                return ResponseEntity.notFound().build();
            } else {
                servicePackageService.deleteByIdByStatus(id);
                return ResponseEntity.ok().body(servicePackage);
            }
    }

    @PutMapping("/{id}")
    public ResponseEntity<Optional<ServicePackage>> updateServicePackage(@PathVariable("id") Long id,
                                                                         @RequestBody ServicePackage servicePackage){
            Optional<ServicePackage> editingServicePackage = servicePackageService.getServicePackage(id);
            if(servicePackage == null) {
                return ResponseEntity.notFound().build();
            } else {
                URI uri = URI.create(ServletUriComponentsBuilder.fromCurrentContextPath()
                        .path("api/service-packages").toUriString());
                return ResponseEntity.created(uri).body(Optional.ofNullable(
                        servicePackageService.saveServicePackage(servicePackage)));
            }
    }

    @GetMapping("/search/{name}")
    public ResponseEntity<Collection<ServicePackage>> getAllServicePackageByName(@PathVariable("name") String name){
        return ResponseEntity.ok().body(servicePackageService.getAllServicePackageByName(name));
    }

    @GetMapping("/sort/price")
    public ResponseEntity<Page<ServicePackage>> getAllServicePackages(
            @RequestParam(defaultValue = "0") int pageNumber,
            @RequestParam(defaultValue = "10") int pageSize,
            @RequestParam(defaultValue = "asc") String sortDirection,
            @RequestParam(defaultValue = "minPrice") String sortField) {

        Sort sort = sortDirection.equalsIgnoreCase("desc") ? Sort.by(sortField).descending() : Sort.by(sortField).ascending();
        Pageable pageable = PageRequest.of(pageNumber, pageSize, sort);

        Page<ServicePackage> servicePackages = servicePackageService.findAll(pageable);
        return ResponseEntity.ok().body(servicePackages);
    }
}
