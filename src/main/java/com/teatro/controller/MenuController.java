package com.teatro.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MenuController {
	@GetMapping("/cargarActores")
	public String mostrarActores() {
		return "actores";
	}
	
	@GetMapping("/cargarCategorias")
	public String mortrarCategorias() {
		return "categorias";
	}
	
	@GetMapping("/cargarRealizarPago")
	public String mostrarRealizarPago() {
		return "realizarPago";
	}
}