import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_learn_app/Controllers/onboarding_controller.dart';

class OnboardingPage extends StatelessWidget {
  final _controller = OnboardingController();

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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            _controller.onboardingPages[index].imageAsset,
                            height: 200,
                            width: 200,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Text(
                            _controller.onboardingPages[index].title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        ),
                        Text(
                          _controller.onboardingPages[index].description,
                          style: TextStyle(fontSize: 15),
                        )
                      ],
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
                // elevation: 0,
                onPressed: () => _controller.goToNextPage(context),
                child:
                    Obx(() => Text(_controller.isLastPage ? 'Start' : 'Next')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
