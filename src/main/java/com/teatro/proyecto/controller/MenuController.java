package com.teatro.proyecto.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.teatro.proyecto.model.Cliente;
import com.teatro.proyecto.model.Funcion;
import com.teatro.proyecto.repository.IClienteRepository;
import com.teatro.proyecto.repository.IEventoRepository;
import com.teatro.proyecto.repository.IFuncionRepository;

@Controller
public class MenuController {
	
	@Autowired
	private IClienteRepository repoCli;
	
	@Autowired
	private IFuncionRepository repoFunc;
	
	@Autowired
	private IEventoRepository repoEven;
	
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
	
	@GetMapping("/cargarRegUsu")
	public String cargarRegUsu(Model model) {
		model.addAttribute("cliente", new Cliente());
		return "registroUsuario";
	}
	
	
	@GetMapping("/login")
	public String abrirPagLogin() {
		return "login";   
	}
	
	@GetMapping("/registroFuncion")
	public String cargarFunc(Model model) {
		model.addAttribute("lstFunciones", repoFunc.findAll());
		model.addAttribute("funcion", new Funcion());
		
		return "registroFuncion";
	}
	
	@PostMapping("/login")
	public String validarAcceso(
			@RequestParam("txtUsuario") String username, 
			@RequestParam("txtClave") String clave,
			Model model) {
		
		Cliente c = repoCli.findByUsernameAndClave(username, clave);
		
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
	
	@PostMapping("/registroUsuario")
	public String registroUsuario(@ModelAttribute Cliente cliente, Model model) {
		System.out.println(cliente);
		try {
			repoCli.save(cliente);
			model.addAttribute("mensaje", "Grabacion OK!");
			model.addAttribute("cssmensaje", "alert alert-success");
		} catch (Exception e) {
			model.addAttribute("mensaje", "Error al grabar");
			model.addAttribute("cssmensaje", "alert alert-danger");
		}
		return "registroUsuario";
	}
}