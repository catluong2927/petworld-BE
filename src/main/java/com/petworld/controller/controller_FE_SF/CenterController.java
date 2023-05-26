package com.petworld.controller.controller_FE_SF;
import com.petworld.dto.centerDto.request.CenterDtoRequest;
import com.petworld.dto.centerDto.response.CenterDtoResponse;
import com.petworld.service.CenterService;
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
@RequestMapping("/api/centers")
@RequiredArgsConstructor
public class CenterController {
    private final CenterService centerService;
    @GetMapping("")
    public ResponseEntity<?> getAllCenters(@PageableDefault(size = 20) Pageable pageable) {
        Optional<Page<CenterDtoResponse>> centerDtoResponses = centerService.findAll(pageable);
        if (centerDtoResponses.isEmpty()) return ResponseEntity.notFound().build();
        return ResponseEntity.ok().body(centerDtoResponses);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getCenterById(@PathVariable(name = "id")Long id){
        Optional<CenterDtoResponse> centerDtoResponse = centerService.getById(id);
        if (centerDtoResponse.isEmpty()) return ResponseEntity.notFound().build();
        return ResponseEntity.ok().body(centerDtoResponse);
    }

    @PostMapping("")
    public ResponseEntity<?> saveCenter(@RequestBody CenterDtoRequest centerDtoRequest){
        Optional<CenterDtoRequest> newCenter = Optional.ofNullable(centerDtoRequest);
        if (newCenter.isEmpty()) return ResponseEntity.badRequest().build();
        URI uri = URI.create(ServletUriComponentsBuilder.fromCurrentContextPath().
                path("api/centers").toUriString());
        return ResponseEntity.created(uri).body(centerService.save(newCenter.get()));
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateCenter(@RequestBody CenterDtoRequest centerDtoRequest){
        Optional<CenterDtoResponse> editedCenter = centerService.getById(centerDtoRequest.getId());
        if (editedCenter.isEmpty()) return ResponseEntity.notFound().build();
        return ResponseEntity.ok().body(centerService.save(centerDtoRequest));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteCenter(@PathVariable(name = "id") Long id){
        Optional<CenterDtoResponse> center = centerService.getById(id);
        if(center.isEmpty()) return ResponseEntity.notFound().build();
        centerService.deleteByIdByStatus(id);
        return ResponseEntity.ok().body(center);
    }
}
