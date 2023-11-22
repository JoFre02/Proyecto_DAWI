package com.teatro.proyecto.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.teatro.proyecto.model.Categoria;

@Repository
public interface ICategoriaRepository extends JpaRepository<Categoria, Integer> {

}
