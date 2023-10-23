import 'dart:convert';

import 'package:country_flags/country_flags.dart';
import 'package:dictionary_app/connector.dart';
import 'package:dictionary_app/homePage.dart';
import 'package:dictionary_app/words.dart';
import 'package:dictionary_app/wordsDao.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'apis/request.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var resultController = TextEditingController();
  var textController = TextEditingController();
  var isVisible = false;
  var countryList = <String>[];
  String sourceLan = "AZ";
  String targetLan="US";
  Future<void> postRequest() async {
    String url = "http://192.168.100.7:8080/api/v1/translate";
    Map<String, String> headers = {"Content-Type": "application/json"};
    WordRequest request = WordRequest(sourceLan.toLowerCase(),targetLan.toLowerCase() , textController.text);
    if(textController.text.isNotEmpty) {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(request.toJson()),
      );
      if (response.statusCode == 200) {
        print("Succes Post From Flutter: ${response.body}");
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        String responseValue = responseData["data"]["translatedText"]
            .toString();
        String utf8Text = utf8.decode(responseValue.codeUnits);
        resultController.text = utf8Text;
      } else {
        print("Error Post From Flutter: ${response.statusCode}, ${response
            .reasonPhrase}");
      }

    }
  }
  Future<void> saveData () async {
     Words words = Words(textController.text, sourceLan, targetLan,resultController.text);
    WordsDao.saveData(words);

  }
  @override
  void initState() {
    super.initState();
    countryList.add("AZ");
    countryList.add("US");
    countryList.add("RU");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title:
            const Text(
            "Translate"
            ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
                InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage(),));
                    },
                    child: SizedBox(height: 180,width: 250, child: Image.asset("images/dictionary.png"))),
              TextField(
                controller: textController,
                decoration: InputDecoration(
                    label: const Text(
                        "Enter"
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(80))
                ),
              ),
              SizedBox(
                child: TextField(
                  controller:resultController ,
                  readOnly: true,
                  decoration: InputDecoration(
                      label: const Text(
                          "Result"
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(80))
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      value: sourceLan,
                      items: countryList.map<DropdownMenuItem<String>>((String value){
                        return DropdownMenuItem<String>(
                          value: value, child: Row(
                            children: [
                              Text(value,style:const TextStyle(
                                color: Colors.deepPurple,fontSize: 20
                            ),),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CountryFlag.fromCountryCode(
                                    value,
                                    height: 20,
                                    width: 20,
                                    borderRadius: 8,
                                ),
                              ),
                            ],
                          ),

                        );
                      }).toList(),
                      icon: const Icon(Icons.arrow_drop_down),
                      onChanged: (String? selected) {
                        setState(() {
                          sourceLan=selected!;
                        });
                      },
                    ),
                  ),
                  const Icon(Icons.arrow_right_alt),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      value: targetLan,
                      items: countryList.map<DropdownMenuItem<String>>((String value){
                        return DropdownMenuItem<String>(
                          value: value, child: Row(
                          children: [
                            Text(value,style:const TextStyle(
                                color: Colors.deepPurple,fontSize: 20
                            ),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CountryFlag.fromCountryCode(
                                value,
                                height: 20,
                                width: 20,
                                borderRadius: 8,
                              ),
                            ),
                          ],
                        ),

                        );

                      }).toList(),
                      icon: const Icon(Icons.arrow_drop_down),
                      onChanged: (String? selected) {
                        setState(() {
                          targetLan=selected!;
                        });
                      },
                    ),
                  ),


                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: isVisible,
                    child: ElevatedButton(
                        onPressed: () {
                        saveData();
                        }, child: const Text("Save Word",
                      style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 20))

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if(textController.text.isNotEmpty){
                              isVisible=true;
                              postRequest();
                            }
                            else{
                              isVisible=false;
                            }
                          });
                        }, child: const Text("Translate",
                        style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 20))

                    ),
                  ),
                ],
              )

            ],
          ),
        ),
      )
    );
  }
}
