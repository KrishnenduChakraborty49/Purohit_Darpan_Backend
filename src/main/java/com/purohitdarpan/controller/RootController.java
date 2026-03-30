package com.purohitdarpan.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RootController {
    @GetMapping("/")
    public String root() {
        return "PUROHIT_DARPAN_API_READY";
    }
}