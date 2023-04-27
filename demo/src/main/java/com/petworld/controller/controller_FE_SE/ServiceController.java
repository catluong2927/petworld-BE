package com.petworld.controller.controller_FE_SE;

import com.petworld.domain.Service;
import com.petworld.service.ServiceService;
import lombok.RequiredArgsConstructor;
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
    @GetMapping("")
    public ResponseEntity<Collection<Service>> getAllServices(){
        return ResponseEntity.ok().body(serviceService.getAllServices());
    }

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
        Optional<Service> editingService = serviceService.getService(id);
        if(service == null) {
            return ResponseEntity.notFound().build();
        } else {
            URI uri = URI.create(ServletUriComponentsBuilder.fromCurrentContextPath()
                    .path("api/service").toUriString());
            return ResponseEntity.created(uri).body(Optional.ofNullable(
                    serviceService.saveService(service)));
        }
    }
}
