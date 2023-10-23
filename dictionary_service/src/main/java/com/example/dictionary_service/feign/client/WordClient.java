package com.example.dictionary_service.feign.client;

import com.example.dictionary_service.feign.request.WordRequest;
import com.example.dictionary_service.feign.response.TranslationResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;



@FeignClient(name = "words",url = "https://text-translator2.p.rapidapi.com/translate")
public interface WordClient {
        @PostMapping(consumes = {MediaType.APPLICATION_FORM_URLENCODED_VALUE})
        TranslationResponse translate(
                @RequestHeader(name = "X-RapidAPI-Host") String host,
                @RequestHeader(name = "X-RapidAPI-Key") String key,
                @RequestBody WordRequest wordRequest);

}
