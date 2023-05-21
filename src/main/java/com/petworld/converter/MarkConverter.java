package com.petworld.converter;

import com.petworld.domain.Mark;
import com.petworld.domain.Product;
import com.petworld.dto.markDto.request.MarkDtoRequest;
import com.petworld.dto.markDto.response.MarkDtoResponse;
import com.petworld.dto.productDto.response.ProductDtoResponse;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
public class MarkConverter {
    public MarkDtoResponse entityToDto(Mark mark){
        MarkDtoResponse markDtoResponse = new MarkDtoResponse();
        BeanUtils.copyProperties(mark, markDtoResponse);
        return markDtoResponse;
    }
    public Mark dtoToEntity(MarkDtoRequest markDtoRequest){
        Mark mark= new Mark();
        BeanUtils.copyProperties(markDtoRequest, mark);
        return mark;
    }
}
