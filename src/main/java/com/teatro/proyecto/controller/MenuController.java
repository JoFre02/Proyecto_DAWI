package com.teatro.proyecto.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MenuController {
		
	@GetMapping("/cargarIndex")
	public String mostrarIndex() {
		return "index";
	}
	
	@GetMapping("/cargarActores")
	public String mostrarActores() {
		return "actores";
	}
	
	@GetMapping("/cargarCategorias")
	public String mostrarCategorias() {
		return "categorias";
	}
	
	@GetMapping("/cargarRealizarPago")
	public String mostrarRealizarPago() {
		return "realizarPago";
	}
		
	@GetMapping("/registroFuncion")
	public String cargarRegFun() {
		return "registroFuncion";
	}
}