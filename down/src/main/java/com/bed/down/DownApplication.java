package com.bed.down;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableAsync;

@SpringBootApplication
@EnableAsync
public class DownApplication {

    public static void main(String[] args) {
        SpringApplication.run(DownApplication.class, args);
    }
}
