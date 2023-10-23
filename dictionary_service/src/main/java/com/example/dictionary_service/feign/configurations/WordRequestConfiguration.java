package com.example.dictionary_service.feign.configurations;

import lombok.Data;
import org.springframework.context.annotation.Configuration;
@Data
@Configuration
public class WordRequestConfiguration {
    private final String host="text-translator2.p.rapidapi.com";
    private final String key="acdbcc7983msh6daea7b04bfac5fp191950jsn3b016ce3f42f";
}
