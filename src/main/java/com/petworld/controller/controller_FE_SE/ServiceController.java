package com.petworld.controller.controller_FE_SE;

import com.petworld.domain.Service;
import com.petworld.domain.ServiceImage;
import com.petworld.dto.servicePackageDto.response.ServicePackageDtoResponse;
import com.petworld.service.ServiceImageService;
import com.petworld.service.ServiceService;
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
@RequestMapping("/api/services")
@RequiredArgsConstructor
public class ServiceController {
    private final ServiceService serviceService;
    private final ServiceImageService serviceImageService;

    @GetMapping("/{id}")
    public ResponseEntity<Optional<Service>> getService(@PathVariable("id") Long id){
        return ResponseEntity.ok().body(serviceService.getService(id));
    }

    @PostMapping("")
    public ResponseEntity<Service> saveServices(@RequestBody Service service){
        URI uri = URI.create(ServletUriComponentsBuilder.fromCurrentContextPath().path("api/service").toUriString());
        return ResponseEntity.created(uri).body(serviceService.saveService(service));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Optional<Service>> removeService(@PathVariable("id") Long id){
        Optional<Service> service = serviceService.getService(id);
        if(service == null) {
            return ResponseEntity.notFound().build();
        } else {
            serviceService.deleteByIdByStatus(id);
            return ResponseEntity.ok().body(service);
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<Optional<Service>> updateService(@PathVariable("id") Long id,
                                                           @RequestBody Service service){
        Optional<Service> editedService = serviceService.getService(id);
        if(editedService == null) {
            return ResponseEntity.notFound().build();
        } else {
            URI uri = URI.create(ServletUriComponentsBuilder.fromCurrentContextPath()
                    .path("api/service").toUriString());
            return ResponseEntity.created(uri).body(Optional.ofNullable(
                    serviceService.saveService(service)));
        }
    }

    @GetMapping()
    public ResponseEntity<Page<Service>> getAllServices(
            @RequestParam(defaultValue = "0") int pageNumber,
            @RequestParam(defaultValue = "10") int pageSize,
            @RequestParam(defaultValue = "asc") String sortDirection,
            @RequestParam(defaultValue = "price") String sortField) {

        Sort sort = sortDirection.equalsIgnoreCase("desc") ? Sort.by(sortField).descending() : Sort.by(sortField).ascending();
        Pageable pageable = PageRequest.of(pageNumber, pageSize, sort);

        Page<Service> services = serviceService.findAll(pageable);
        return ResponseEntity.ok().body(services);
    }
}
