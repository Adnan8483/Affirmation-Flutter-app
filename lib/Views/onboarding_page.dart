import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_learn_app/Controllers/home_controller.dart';
import 'package:my_learn_app/Controllers/onboarding_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:my_learn_app/Services/local_notification.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class OnboardingPage extends StatefulWidget {
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _controller = OnboardingController();
  final HomeController controller = Get.put(HomeController());
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    controller.readJsonApi("https://deveffocess.github.io/sample.json");

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          NotificationServices.createanddisplaynotification(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data}");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
                controller: _controller.pageController,
                onPageChanged: _controller.selectedPageIndex,
                itemCount: _controller.onboardingPages.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            _controller.onboardingPages[index].bg_image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Image.asset(
                          //     _controller.onboardingPages[index].imageAsset,
                          //     height: 200,
                          //     width: 200,
                          //   ),
                          // ),
                          Container(
                            padding:
                                const EdgeInsets.only(left: 20.0, bottom: 5),
                            child: Text(
                                _controller.onboardingPages[index].title,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.bebasNeue(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 35,
                                        color: Colors.white))),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              _controller.onboardingPages[index].description,
                              style: GoogleFonts.bebasNeue(
                                  textStyle: TextStyle(
                                      fontSize: 17, color: Colors.white)),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
            Positioned(
              bottom: 25,
              left: 20,
              child: Row(
                children: List.generate(
                    _controller.onboardingPages.length,
                    (index) => Obx(() {
                          return Container(
                            margin: const EdgeInsets.all(4),
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    _controller.selectedPageIndex.value == index
                                        ? Colors.blue
                                        : Colors.grey),
                          );
                        })),
              ),
            ),
            Positioned(
              right: 20,
              bottom: 20,
              child: TextButton(
                onPressed: () => _controller.goToNextPage(context),
                child: Obx(() => Text(
                      _controller.isLastPage ? 'Start' : 'Next',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
