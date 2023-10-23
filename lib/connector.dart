import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
class Connector{

  static Future<Database?> getDb() async {

    String dbPath = join(await getDatabasesPath(), 'dictionary.db');
    File dbFile = File(dbPath);

    if (!dbFile.existsSync()) {
      // Eğer veritabanı dosyası yoksa, yeni bir tane oluştur.
      ByteData data = await rootBundle.load("assets/dictionary.db");
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await dbFile.writeAsBytes(bytes, flush: true);
      print("Database copied");
    }

    return openDatabase(dbPath);
  }

  }