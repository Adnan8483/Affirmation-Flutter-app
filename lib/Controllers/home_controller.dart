import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:my_learn_app/Models/home_info.dart';
import 'package:my_learn_app/Views/premium_page.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            category TEXT,
            is_like INTEGER NOT NULL DEFAULT 0
          )
        ''');
      },
    );
  }

  //Method to get data from api and set in sql db.
  Future<HomeInfo> readJsonApi(String api) async {
    //Initialize db if its not initialize so it does not show db error.
    if (_database == null) {
      await initDatabase();
    }

    try {
      var url = Uri.parse(api);
      var response = await client.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> dataMap = jsonDecode(response.body);
        final homeInfo = HomeInfo.fromJson(dataMap);

        List<Map<String, String>> affirmationsArr = [];
        for (var affirmation in dataMap['affirmation_List']) {
          Map<String, String> affirmationObject = {
            'affirmation': affirmation['affirmation'],
            'category': affirmation['category']
          };

          affirmationsArr.add(affirmationObject);
          // print(affirmationsArr[0]['category']);
        }

        // Insert data into database
        for (int i = 0; i < affirmationsArr.length; i++) {
          await _database?.insert('Affirmation_table', {
            'affirmation': affirmationsArr[i]['affirmation'],
            'category': affirmationsArr[i]['category']
          });
        }

        return homeInfo;
      } else {
        return HomeInfo.fromJson({"error": "oops something went wrong!"});
      }
    } on SocketException catch (e) {
      if (e.osError?.errorCode == -7) {
        // Failed host lookup, indicating potential internet connection issue
        print('!!!Failed host lookup: ${e.osError?.errorCode}');
        print('@@@Please check your internet connection.');
        // Display a message to the user indicating the internet connection issue
      } else {
        // Other SocketException occurred, handle it accordingly
        print('###SocketException occurred: $e');
      }

      throw Exception("*** No internet connection");
    } catch (e) {
      // Other exception occurred, handle it accordingly
      print('Exception occurred: $e');
    }

    // Default return statement if no other return statement is reached
    return HomeInfo();
  }

  //Method to get favourite affirmation from db.
  Future<List<AffirmationList>> getFavouriteAffirmation() async {
    if (_database == null) {
      await initDatabase();
    }
    final List<Map<String, dynamic>> results = await _database!
        .query('Affirmation_table', where: 'is_like = ?', whereArgs: [1]);
    return results.map((map) => AffirmationList.fromJson(map)).toList();
  }

  //Method to get all affirmations to display.
  Future<List<AffirmationList>> getAllAffirmations() async {
    if (_database == null) {
      await initDatabase();
    }
    final List<Map<String, dynamic>> results =
        await _database!.query('Affirmation_table');
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

  goToPremium(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PremiumPage()));
  }

  Future<void> saveSelectedCategories(List<String> selectedCategories) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('selected_categories', selectedCategories);
  }

  Future<List<String>> loadSelectedCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('selected_categories') ?? [];
  }
}
