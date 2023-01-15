package com.springboot.springbootfirstapp;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestControllerSimple {

	@RequestMapping("/hello") 
	public String test() {
		 return "Congratualations!!!! Sucessfully deployed application in k8s";
	 }
}
