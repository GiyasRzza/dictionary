import 'package:country_flags/country_flags.dart';
import 'package:dictionary_app/words.dart';
import 'package:dictionary_app/wordsDao.dart';
import 'package:flutter/material.dart';

import 'detailPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSearch = false;
  String searchWord="";
  Future<List<Words>> getAllWord() async {
    var wordList = await WordsDao.getAllWords();
    return wordList;
  }
  Future<List<Words>> wordSearch(String word) async {
    var allWord = WordsDao.wordSearch(word);
    return allWord;
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: isSearch?
        TextField(
          onChanged: (value) {
            setState(() {
              searchWord =value;
            });
          },
          decoration: const InputDecoration(
            hintText: "Search You Word",
          ),

        )
            :const Text("Dictionary"),
        actions: [
          isSearch?
          IconButton(
              onPressed:() {
                setState(() {
                  isSearch=false;
                  searchWord="";
                });
              },
              icon: const Icon(Icons.cancel)
          )
              : IconButton(
              onPressed:() {
                setState(() {
                  isSearch=true;
                });
              },
              icon: const Icon(Icons.search)
          )
        ],
      ),
      body: FutureBuilder<List<Words>>(
        future: isSearch?
        wordSearch(searchWord)
            : getAllWord(),
        builder: (BuildContext context, AsyncSnapshot<List<Words>> snapshot) {
          if(snapshot.hasData){
            var wordList = snapshot.data;
            return ListView.builder(
              itemCount: wordList?.length,
              itemBuilder: (context, index) {
                var word = wordList?[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  DetailsPage(words: word),));
                  },
                  child: SizedBox(
                    height: screenHeight/15,
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(word!.word,style: const TextStyle(fontWeight: FontWeight.bold),),
                          CountryFlag.fromCountryCode(
                            word.source,
                            height: screenHeight/20,
                            width: screenWidth/20,
                            borderRadius: 8,
                          ),
                          Text(word.source,style: const TextStyle(fontWeight: FontWeight.bold),),
                          const Icon(Icons.arrow_right_alt),
                          Text(word.target,style: const TextStyle(fontWeight: FontWeight.bold),),
                          CountryFlag.fromCountryCode(
                            word.target,
                            height: screenHeight/20,
                            width: screenWidth/20,
                            borderRadius: 8,
                          ),
                          Text(word.transWord,style: const TextStyle(fontWeight: FontWeight.bold),),

                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          else{
            return const Center();
          }
        },
      ),
    );
  }
}
