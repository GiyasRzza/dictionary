class WordRequest{
  String source_language;
  String target_language;
  String text;


  WordRequest(this.source_language, this.target_language, this.text);

  Map<String, dynamic> toJson() {
    return {
      'source_language': source_language,
      'target_language': target_language,
      'text':text,
    };
  }
}