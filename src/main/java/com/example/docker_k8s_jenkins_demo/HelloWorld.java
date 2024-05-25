package com.example.docker_k8s_jenkins_demo;


import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/hello")
public class HelloWorld {

    @GetMapping("/world")
    public String helloWorld(){
        System.out.println("Printing Hello..");
        return "Hello World..";
    }
}
