package com.teatro.proyecto.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.teatro.proyecto.model.Funcion;
import com.teatro.proyecto.repository.IFuncionRepository;

@Controller
public class FuncionController {

	@GetMapping("/cargaFuncion")
	public String abrirPagFuncion() {
		return "registroFuncion";
	}
	
	@Autowired
	private IFuncionRepository repoFun;
}
