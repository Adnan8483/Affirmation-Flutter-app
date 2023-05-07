import 'package:get/state_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_learn_app/Models/onboarding_info.dart';
import 'package:my_learn_app/Models/premium_info.dart';

class PremiumController extends GetxController {
  List<PremiumInfo> PremiumPages = [
    PremiumInfo('assets/images/logo.jpg'),
    PremiumInfo('assets/images/logo.jpg'),
    PremiumInfo('assets/images/logo.jpg')
  ];
}
