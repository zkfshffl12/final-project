package com.bed.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
    
    @GetMapping("/")
    public String index() {
        return "index";
    }
    
    @GetMapping("/dashboard")
    public String dashboard() {
        return "index";
    }
    
    @GetMapping("/monitor")
    public String monitor() {
        return "index";
    }
}
