package com.teatro.proyecto.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.teatro.proyecto.model.Cliente;
import com.teatro.proyecto.repository.IClienteRepository;
//poto
@Controller
public class MenuController {
	
	@Autowired
	private IClienteRepository repoCli;
	
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
	
	@GetMapping("/registroUsuario")
	public String cargarRegUsu() {
		return "registroUsuario";
	}
	
	
	@GetMapping("/login")
	public String abrirPagLogin() {
		return "login";   
	}
	
	@GetMapping("/registroFuncion")
	public String cargarRegFun() {
		return "registroFuncion";
	}
	
	@PostMapping("/login")
	public String validarAcceso(
			@RequestParam("txtUsuario") String username, 
			@RequestParam("txtClave") String clave,
			Model model) {
		
		Cliente c = repoCli.findByUsernameAndClave(username, clave);
		System.out.println(c);
		
		if (c != null) {
			model.addAttribute("mensaje", "Bienvenido: " + c.getNomcli());
			model.addAttribute("cssmensaje", "alert alert-success");
			 return "redirect:/cargarIndex";
		} else {
			model.addAttribute("mensaje", "Usuario o clave incorrecto");
			model.addAttribute("cssmensaje", "alert alert-danger");
		}
		
		return "login";
	}
}