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
        'assets/images/logo.jpg',
        'assets/images/onBoarding_BgImg/onBoarding_bg_1.jpg',
        'Hey! \nWelcome to the \nInspira',
        'Let our curated collection of powerful quotes inspire and uplift you on your journey to greatness.'),
    OnboardingInfo(
        'assets/images/logo.jpg',
        'assets/images/onBoarding_BgImg/onBoarding_bg_4_resize.jpg',
        'Embrace the Power of \nAffirmations',
        'Harness the power of affirmations to create positive change in your life. Choose from a wide range of categories and personalize your experience.'),
    OnboardingInfo(
        'assets/images/logo.jpg',
        'assets/images/onBoarding_BgImg/onBoarding_bg_7_resize.jpg',
        'Daily Challenges for \nGrowing',
        'Challenge yourself to step out of your comfort zone and unlock your hidden potential.')
  ];
}
