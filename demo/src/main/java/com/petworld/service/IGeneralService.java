package com.petworld.service;

import java.util.List;

public interface IGeneralService <T>{
    List<T> findAll();

    T findById(Long id);

    T findByName(String name);

    void remove(Long id);

    T save (T t) ;



}
