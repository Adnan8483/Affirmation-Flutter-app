import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:my_learn_app/Models/home_info.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:my_learn_app/Views/catagories_page.dart';
import 'package:my_learn_app/Views/premium_page.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

class HomeController extends GetxController {
  var client = http.Client();

  Database? _database;

  @override
  void onInit() {
    super.onInit();
    initDatabase();
  }

//Create database fro store affiramtinos.
  Future<void> initDatabase() async {
    _database = await openDatabase(
      'affirmationAppDatabase.db',
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE Affirmation_table (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            affirmation TEXT,
            is_like INTEGER NOT NULL DEFAULT 0
          )
        ''');
      },
    );
  }

  //Method to get data from api and set in sql db.
  Future<HomeInfo> readJsonApi(String api) async {
    bool isDatabaseCreated = await databaseExists('affiramtionAppDatabase.db');
    if (isDatabaseCreated) {
      print('Database already exists!');
    } else {
      print('Database does not exist yet.');
    }

    var url = Uri.parse(api);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> dataMap = jsonDecode(response.body);
      final homeInfo = HomeInfo.fromJson(dataMap);

      List<String> affirmationsArr = [];
      for (var affirmation in dataMap['affirmation_List']) {
        affirmationsArr.add(affirmation['affirmation']);
      }

      // Insert data into database
      for (int i = 0; i < affirmationsArr.length; i++) {
        await _database
            ?.insert('Affirmation_table', {'affirmation': affirmationsArr[i]});
      }

      // List<AffirmationList> affirmationData = await getAllAffirmations();
      // print('%%% getAllAffirmations From SQL :- $affirmationData');

      // print("%%%% this is affirmations:- $dataMap");
      return homeInfo;
      // print("### this is jsonDecode DATA:- $dataMap");
    } else {
      return HomeInfo.fromJson({"error": "oops something went wrong!"});
    }
  }

  //Method to get favourite affirmation from db.
  Future<List<AffirmationList>> getFavouriteAffirmation() async {
    if (_database == null) {
      await initDatabase();
    }
    final List<Map<String, dynamic>> results = await _database!
        .query('Affirmation_table', where: 'is_like = ?', whereArgs: [1]);
    print("##@@Get Favourite aff INSIDE data:-$results");
    return results.map((map) => AffirmationList.fromJson(map)).toList();
  }

  //Method to get all affirmations to display.
  Future<List<AffirmationList>> getAllAffirmations() async {
    if (_database == null) {
      await initDatabase();
    }
    final List<Map<String, dynamic>> results =
        await _database!.query('Affirmation_table');
    // print("##@@Get all function INSIDE data:-$results");
    return results.map((map) => AffirmationList.fromJson(map)).toList();
  }

  //Method to update LIKE true Data in sql.
  Future<void> updateAffirmationFavouriteStatus(
      int id, bool isLike, Function callback) async {
    if (_database == null) {
      await initDatabase();
    }
    print("@@@ isLike Value in UPDATE: $isLike");
    final db = await _database;
    await db?.update(
      'Affirmation_table',
      {'is_like': !isLike ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );

    callback();
  }

  goToCatagory(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CatagoriesPage()));
  }

  goToPremium(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PremiumPage()));
  }
}
