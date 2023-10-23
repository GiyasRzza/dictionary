package com.example.dictionary_service.service;

import com.example.dictionary_service.feign.client.WordClient;
import com.example.dictionary_service.feign.configurations.WordRequestConfiguration;
import com.example.dictionary_service.feign.request.WordRequest;
import com.example.dictionary_service.feign.response.TranslationResponse;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class WordService {
   private final WordClient wordClient;
    private final WordRequestConfiguration configuration;
    public TranslationResponse translate(WordRequest wordRequest){
        if (wordRequest.getSource_language().equals("us")){
            wordRequest.setSource_language("en");
        }
        if (wordRequest.getTarget_language().equals("us")) {
            wordRequest.setTarget_language("en");
        }
      return wordClient.translate(configuration.getHost(),
              configuration.getKey(), wordRequest);
    }
}
