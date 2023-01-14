package com.springboot.springbootfirstapp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class SpringbootFirstappApplication {

	@GetMapping
	public String message(){
		return "Congratulations, successfully deployed using Kubernetes k*s";
	}
		public static void main(String[] args) {
		SpringApplication.run(SpringbootFirstappApplication.class, args);
	}

}
