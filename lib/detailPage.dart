import 'package:country_flags/country_flags.dart';
import 'package:dictionary_app/words.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
    Words words;
   DetailsPage({super.key,required this.words});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: const Text("Details"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
             Text(
              widget.words.word,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 40,color: Colors.pink),
            ),
            CountryFlag.fromCountryCode(
              widget.words.source,
              height:100,
              width: 100,
              borderRadius: 8,
            ),
            SizedBox(
                width: 200,
                height: 200,
                child: Image.asset("images/arrow.png")),
            CountryFlag.fromCountryCode(
              widget.words.target,
              height:100,
              width: 100,
              borderRadius: 8,
            ),
            Text(
                widget.words.transWord,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 40,),
            ),

          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
