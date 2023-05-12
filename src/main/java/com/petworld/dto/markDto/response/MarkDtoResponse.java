package com.petworld.dto.markDto.response;

import lombok.*;
import javax.persistence.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MarkDtoResponse {
    private String tag;
    @Column(name = "tag_badge")
    private String tagBadge;
}
