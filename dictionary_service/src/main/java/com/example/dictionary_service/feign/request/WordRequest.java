package com.example.dictionary_service.feign.request;


import lombok.Data;
@Data
public class WordRequest {
    String source_language;
    String target_language;
    String text;

}
