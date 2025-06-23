package com.vetid;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class VetidApplication {

	public static void main(String[] args) {
		SpringApplication.run(VetidApplication.class, args);
		System.out.println("Nuevo cambio");
	}

}
