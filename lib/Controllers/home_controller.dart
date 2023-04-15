import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:my_learn_app/Models/home_info.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:my_learn_app/Views/catagories_page.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var client = http.Client();
  Future<HomeInfo> readJsonApi(String api) async {
    var url = Uri.parse(api);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> dataMap = jsonDecode(response.body);
      final homeInfo = HomeInfo.fromJson(dataMap);

      // print("@@@ this is datamap:- $dataMap");
      return homeInfo;
      // print("### this is jsonDecode DATA:- $dataMap");
    } else {
      return HomeInfo.fromJson({"error": "oops something went wrong!"});
    }
  }

  goToCatagory(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CatagoriesPage()));
  }
}
