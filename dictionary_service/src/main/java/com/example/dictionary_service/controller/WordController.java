package com.example.dictionary_service.controller;

import com.example.dictionary_service.feign.request.WordRequest;
import com.example.dictionary_service.feign.response.TranslationResponse;
import com.example.dictionary_service.service.WordService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@AllArgsConstructor
@RequestMapping("api/v1")
public class WordController {
   private final WordService wordService;
   @PostMapping("translate")
   TranslationResponse translate(@RequestBody WordRequest wordRequest){
       return wordService.translate(wordRequest);
   }
}
