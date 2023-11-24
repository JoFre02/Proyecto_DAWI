package com.teatro.proyecto.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.teatro.proyecto.model.Cliente;
import com.teatro.proyecto.repository.IClienteRepository;

@Controller
public class LoginController {

	@Autowired
	private IClienteRepository repoCli;
	
	@GetMapping("/login")
	public String abrirPagLogin() {
		return "login";   
	}
	
	@GetMapping("/registroUsuario")
	public String cargarRegUsu(Model model) {
		
		model.addAttribute("cliente", new Cliente());
		
		return "registroUsuario";
	}
	
	@PostMapping("/login")
	public String validarAcceso(
			@RequestParam("txtUsuario") String username, 
			@RequestParam("txtClave") String clave,
			Model model) {
		
		Cliente c = repoCli.findByUsernameAndClave(username, clave);
		System.out.println(c);
		
		if (c != null) {
			model.addAttribute("mensaje", "Bienvenido: Admin");
			model.addAttribute("cssmensaje", "alert alert-success");
			return "redirect:/cargarIndex";
		} else {
			model.addAttribute("mensaje", "Usuario o clave incorrecto");
			model.addAttribute("cssmensaje", "alert alert-danger");
		}
		return "login";
	}
	
	@PostMapping("/registrar")
	public String grabarUsuario(@ModelAttribute Cliente cliente, Model model) {
		try {
			repoCli.save(cliente);
			model.addAttribute("mensaje", "Grabacion OK!");
			model.addAttribute("cssmensaje", "alert alert-success");
		} catch (Exception e) {
			model.addAttribute("mensaje", "Error al grabar");
			model.addAttribute("cssmensaje", "alert alert-danger");
		}
		return "login";
	}
}
