package com.teatro.proyecto.controller;

import java.io.OutputStream;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.teatro.proyecto.model.Cliente;
import com.teatro.proyecto.model.Evento;
import com.teatro.proyecto.model.Funcion;
import com.teatro.proyecto.repository.ICategoriaRepository;
import com.teatro.proyecto.repository.IClienteRepository;
import com.teatro.proyecto.repository.IEventoRepository;
import com.teatro.proyecto.repository.IFuncionRepository;

import jakarta.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;

@Controller
public class MenuController {
	
	@Autowired
	private ICategoriaRepository repoCat;
	
	@Autowired
	private IClienteRepository repoCli;
	
	@Autowired
	private IFuncionRepository repoFunc;
	
	@Autowired
	private IEventoRepository repoEven;
	
	@Autowired
	private DataSource dataSource;

	@Autowired
	private ResourceLoader resourceLoader;
	
	@GetMapping("/cargarIndex")
	public String mostrarIndex(Model model) {
		model.addAttribute("lstEventos", repoEven.findAll());
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
	
	@GetMapping("/cargarRealizarEvento")
	public String mostrarRealizarEvento(Model model) {
		model.addAttribute("lstCategorias", repoCat.findAll());
		model.addAttribute("evento", new Evento());
		return "registrarEvento";
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
	@GetMapping("/detalleEvento")
	public String abrirDetalleEvento() {
		return "detalleEvento";  
	}
	
	// listar funciones
	@GetMapping("/registroFuncion")
	public String cargarFunc(Model model) {
		model.addAttribute("lstFunciones", repoFunc.findAll());
		model.addAttribute("lstEventos", repoEven.findAll());
		model.addAttribute("funcion", new Funcion());
		
		return "registroFuncion";
	}
	
	// registrar funciones
	@PostMapping("/registroFuncion")
	public String registroFuncion(@ModelAttribute Funcion funcion, Model model) {
		try {
			repoFunc.save(funcion);
			model.addAttribute("lstFunciones", repoFunc.findAll());
			model.addAttribute("mensaje", "REGISTRO OK");
		} catch (Exception e) {
			model.addAttribute("lstFunciones", repoFunc.findAll());
			model.addAttribute("mensaje", "ERROR AL REGISTRAR");
		}
		
		return "registroFuncion";
		
	}
	
	@PostMapping("/registrarEvento")
	public String registrarEvento(@ModelAttribute Evento evento, Model model) {
		model.addAttribute("lstCategorias", repoCat.findAll());
		try {
			repoEven.save(evento);
			model.addAttribute("mensaje", "REGISTRO OK");
		} catch (Exception e) {
			model.addAttribute("mensaje", "ERROR AL REGISTRAR");
			System.out.println("" + evento);
		}
		
		return "redirect:/registroFuncion";
		
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
	
	@GetMapping("/reporteFuncion")
	public void reporteFuncion(HttpServletResponse response) {
		response.setHeader("Content-Disposition", "inline;");
		response.setContentType("application/pdf");
		try {
			String ru = resourceLoader.getResource("classpath:reporteFuncion.jasper").getURI().getPath();
			JasperPrint jasperPrint = JasperFillManager.fillReport(ru, null, dataSource.getConnection());
			OutputStream outStream = response.getOutputStream();
			JasperExportManager.exportReportToPdfStream(jasperPrint, outStream);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}