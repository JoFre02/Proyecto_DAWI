package com.teatro.proyecto.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.teatro.proyecto.model.Funcion;

@Repository
public interface IFuncionRepository extends JpaRepository<Funcion, Integer> {
	

}
