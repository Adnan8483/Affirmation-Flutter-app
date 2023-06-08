import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:my_learn_app/Models/premium_info.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

class PremiumController extends GetxController {
  List<PremiumInfo> PremiumPages = [
    PremiumInfo('assets/images/crown.png'),
  ];

  static void launchUrl(String url) async {
    try {
      await FlutterWebBrowser.openWebPage(url: url);
    } catch (e) {
      print(e.toString());
    }
  }
}
