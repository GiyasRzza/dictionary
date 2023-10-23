import 'dart:io';

import 'package:dictionary_app/connector.dart';
import 'package:dictionary_app/words.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';


class WordsDao{
 static  Future<List<Words>> getAllWords() async {
    var db = await Connector.getDb();
    List<Map<String,dynamic>> maps = await db!.rawQuery("select * from words");

    return List.generate(maps.length, (index) {
       var row = maps[index];
       return Words(row["word"],row["source"],row["target"],row["trans_word"]);
     });
  }
 static Future<void> findApplicationDatabasePath() async {
   WidgetsFlutterBinding.ensureInitialized();

   Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
   print("Uygulamanın belgeler dizini: ${appDocumentsDirectory.path}");
 }

 static  Future<List<Words>> wordSearch(String word) async {
   var db = await Connector.getDb();
   List<Map<String,dynamic>> maps = await db!.rawQuery("select * from words where en like '%$word%'");
   return List.generate(maps.length, (index) {
     var row = maps[index];
     return Words(row["word"],row["source"],row["target"],row["trans_word"]);
   });
 }

 static Future<void> saveData(Words words)async {
   var db = await Connector.getDb();
   var info = <String, dynamic>{};
   info["word"] = words.word;
   info["source"] = words.source;
   info["target"] = words.target;
   info["trans_word"] = words.transWord;
   print("Insert result: ${await db!.insert("words", info)}");
    // await db.delete("words");

 }

 // static Future<void> saveData(Words words) async {
 //   // try {
 //   var db = await Connector.getDb();
 //   await db!.rawInsert('INSERT INTO words (word, source, target, trans_word) VALUES (?, ?, ?, ?)',
 //       ['${words.word}', '${words.source}', '${words.target}', '${words.transWord}']);
 //
 //
 // }
 // static Future<void> saveData(Words words) async {
 //   var db = await Connector.getDb();
 //   var info = <String, dynamic>{
 //     "word": words.word,
 //     "source": words.source,
 //     "target": words.target,
 //     "trans_word": words.transWord,
 //   };
 //
 //   await db!.transaction((txn) async {
 //     await txn.rawQuery('BEGIN IMMEDIATE');
 //     try {
 //       await txn.insert("words", info);
 //       await txn.rawQuery('COMMIT');
 //     } catch (e) {
 //       await txn.rawQuery('ROLLBACK');
 //     }
 //   });
 static void deleteFile() async {
   WidgetsFlutterBinding.ensureInitialized();

   Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();


   List<FileSystemEntity> files = appDocumentsDirectory.listSync();

   // Tüm dosyaları sil
   files.forEach((file) {
     if (file is File) {
       file.deleteSync();
     }
   });

   print("Tüm SQLite veritabanı dosyaları silindi.");
 }
  }

