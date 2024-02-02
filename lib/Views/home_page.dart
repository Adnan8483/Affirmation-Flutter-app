import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:my_learn_app/Controllers/home_controller.dart';
import 'package:my_learn_app/Controllers/onboarding_controller.dart';
import 'package:my_learn_app/Models/home_info.dart';
import 'package:get/state_manager.dart';
import 'package:my_learn_app/Views/catagories_page.dart';
import 'package:my_learn_app/Services/local_notification.dart';
import 'package:share/share.dart';
import 'favourite_quotes_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.put(HomeController());
  final onBoardingController = OnboardingController();

  List<int> selectedQuote = [];
  List<AffirmationList> affirmationList = [];
  List<String> _selectedCategories = ['random'];

  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    notificationServices.initializeNotifications(
        onNotificationTap: handleNotificationTap);
    controller.readJsonApi("https://deveffocess.github.io/sample.json");
    loadAffirmations();
    controller.loadSelectedCategories().then((categories) {
      setState(() {
        _selectedCategories = categories;
      });
    });

    onBoardingController.setOnboardingStatus();
  }

//For getting notification payload value.
  void handleNotificationTap(String? payload) {
    if (payload != null) {
      int affirmationId = int.parse(payload);
      if (affirmationId != null) {
        print(
            '### IN HOME ### Notification tapped for affirmation ID: $affirmationId');
      }
    }
  }

  void loadAffirmations() async {
    // get affirmation data from database and set the state
    List<AffirmationList> data = await controller.getAllAffirmations();
    setState(() {
      affirmationList = data;
    });
  }

  goToCategory(BuildContext context) async {
    final List<String>? result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => CatagoriesPage()));

    if (result != null) {
      setState(() {
        _selectedCategories = result;
      });
      await controller.saveSelectedCategories(_selectedCategories);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: appBar(context),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_img/bg_img_2.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: FutureBuilder<List<AffirmationList>>(
            future: controller.getAllAffirmations(),
            builder: (context, snapshot) {
              // print("%Snapshot :-${snapshot.data}");
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.data!.isEmpty) {
                return Stack(
                  children: [
                    Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                          ]),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Please check your internet connection!',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                );
              } else {
                final affirmationList = snapshot.data!;
                List<AffirmationList> filteredList =
                    affirmationList.where((affirmation) {
                  if (_selectedCategories.isEmpty ||
                      _selectedCategories.contains('random')) {
                    return true; // no categories selected, show all affirmations
                  } else {
                    return _selectedCategories.contains(affirmation.category ??
                        ''); // show affirmations for selected categories
                  }
                }).toList();
                return Stack(
                  children: [
                    PageView.builder(
                      key: PageStorageKey('affirmationPageView'),
                      scrollDirection: Axis.vertical,
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final affirmation =
                            filteredList[index].affirmation ?? '';
                        final aff_id = filteredList[index].id ?? 0;
                        final aff_is_like = filteredList[index].is_like == 1;
                        return Stack(
                          children: [
                            Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        affirmation,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 24),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                  ]),
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              padding: EdgeInsets.all(100),
                              // height: 100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    iconSize: 30.0,
                                    icon: const Icon(Icons.share),
                                    onPressed: () {
                                      Share.share(affirmation);
                                    },
                                  ),
                                  IconButton(
                                    iconSize: 30.0,
                                    icon: Icon(aff_is_like
                                        ? Icons.favorite_sharp
                                        : Icons.favorite_border),
                                    onPressed: () {
                                      controller
                                          .updateAffirmationFavouriteStatus(
                                        aff_id,
                                        aff_is_like,
                                        () {
                                          setState(() {
                                            AffirmationList affirmation =
                                                filteredList.firstWhere(
                                                    (element) =>
                                                        element.id == aff_id);
                                            affirmation.is_like =
                                                !aff_is_like ? 1 : 0;
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.all(15),
                      // height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 8.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                primary: Colors.white),

                            onPressed: () => {goToCategory(context)},
                            icon: const Icon(
                              Icons.grid_view_outlined,
                              size: 24.0,
                              color: Colors.black,
                            ),
                            label: Text('categories',
                                style:
                                    TextStyle(color: Colors.black)), // <-- Text
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 8.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                primary: Colors.white),

                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FavouritePage()))
                            },
                            icon: const Icon(
                              Icons.bookmark,
                              size: 20.0,
                              color: Colors.black,
                            ),
                            label: Text('Bookmark',
                                style:
                                    TextStyle(color: Colors.black)), // <-- Text
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ));
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.black),
      elevation: 0,
      actions: [
        //** Hide Premium button for this version. */

        // GestureDetector(
        //   onTap: () {
        //     controller.goToPremium(context);
        //   },
        //   child: Container(
        //     child: Center(
        //       child: Container(
        //         height: 30,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(15),
        //           image: const DecorationImage(
        //             fit: BoxFit.cover,
        //             image: AssetImage(
        //                 'assets/images/background_img/bg_img_1_crop.jpeg'),
        //           ),
        //         ),
        //         child: ClipRRect(
        //           borderRadius: const BorderRadius.all(Radius.circular(50)),
        //           child: Shimmer(
        //             duration: const Duration(seconds: 4),
        //             interval: const Duration(seconds: 1),
        //             color: Colors.white,
        //             child: Align(
        //               alignment: Alignment.center,
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
        //                 crossAxisAlignment: CrossAxisAlignment.center,
        //                 children: const [
        //                   SizedBox(
        //                     width: 8,
        //                   ),
        //                   Icon(
        //                     color: Colors.white,
        //                     FontAwesomeIcons.crown,
        //                     size: 16,
        //                   ),
        //                   SizedBox(
        //                     width: 6,
        //                   ),
        //                   Text(
        //                     'Premium',
        //                     style: TextStyle(
        //                       color: Colors.white,
        //                       fontWeight: FontWeight.bold,
        //                     ),
        //                   ),
        //                   SizedBox(
        //                     width: 8,
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }
}
