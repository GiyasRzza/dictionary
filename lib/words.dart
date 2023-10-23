class Words{
  late int wordId;
  late String word;
  late String source;
  late String target;
  late String transWord;

  Words(this.word, this.source, this.target,this.transWord);
  Map<String, dynamic> toMap() {
    return {
      'id': wordId,
      'word': word,
      'source': source,
      'target': target,
      'trans_word': transWord,
    };
  }
}
