package com.petworld.controller.controller_FE_SF;

import com.petworld.dto.centerDto.response.CenterDtoResponse;
import com.petworld.entity.Service;
import com.petworld.dto.serviceDto.request.ServiceDtoRequest;
import com.petworld.dto.serviceDto.response.ServiceDtoResponse;
import com.petworld.service.ServiceService;
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
@RequestMapping("/api/services")
@RequiredArgsConstructor
public class ServiceController {
    private final ServiceService serviceService;
    @GetMapping("")
    public ResponseEntity<?> getAllServices(@PageableDefault(size = 9) Pageable pageable) {
        Page<ServiceDtoResponse> serviceDtoResponses = serviceService.findAll(pageable);
        if (serviceDtoResponses.isEmpty()) return ResponseEntity.notFound().build();
        return ResponseEntity.ok().body(serviceDtoResponses);
    }
    @GetMapping("/{id}")
    public ResponseEntity<?> getService(@PathVariable("id") Long id) {
        Optional<ServiceDtoResponse> service = serviceService.getService(id);
        if (service.isEmpty()) return ResponseEntity.notFound().build();
        return ResponseEntity.ok().body(service);
    }
    @PostMapping("")
    public ResponseEntity<Service> saveServices(@RequestBody ServiceDtoRequest service) {
        URI uri = URI.create(ServletUriComponentsBuilder.fromCurrentContextPath().path("api/service").toUriString());
        return ResponseEntity.created(uri).body(serviceService.saveService(service));
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<?> removeService(@PathVariable("id") Long id) {
        Optional<ServiceDtoResponse> service = serviceService.getService(id);
        if (service.isEmpty()) return ResponseEntity.notFound().build();
        else {
            serviceService.deleteByIdByStatus(id);
            return ResponseEntity.ok().body(service);
        }
    }
    @PutMapping("/{id}")
    public ResponseEntity<?> updateService(@RequestBody ServiceDtoRequest service) {
        Optional<ServiceDtoResponse> editedService = serviceService.getService(service.getId());
        if (editedService == null) return ResponseEntity.notFound().build();
        else return ResponseEntity.ok().body(serviceService.saveService(service));
    }

    @GetMapping("/package-detail/{id}")
    public ResponseEntity<?> getCentersByPackageDetailId(@PathVariable(name = "id") Long id,Pageable pageable) {
        Optional<Page<ServiceDtoResponse>> serviceDtoResponses = serviceService.findByPackageId(id,pageable);
        if (serviceDtoResponses.isEmpty()) return ResponseEntity.notFound().build();
        return ResponseEntity.ok().body(serviceDtoResponses);
    }
}
