import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_learn_app/Models/onboarding_info.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';
import 'package:my_learn_app/Views/home_page.dart';

class OnboardingController extends GetxController {
  var selectedPageIndex = 0.obs;
  var pageController = PageController();

  bool get isLastPage => selectedPageIndex.value == onboardingPages.length - 1;

  goToNextPage(BuildContext context) {
    if (isLastPage) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
    }
  }

  List<OnboardingInfo> onboardingPages = [
    OnboardingInfo(
        'assets/images/logo.jpg', '1st page', '1st Description of this page'),
    OnboardingInfo(
        'assets/images/logo.jpg', '2nd page', '2nd Description of this page'),
    OnboardingInfo(
        'assets/images/logo.jpg', '3rd page', '3rd Description of this page')
  ];
}
