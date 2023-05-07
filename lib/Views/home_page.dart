import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:my_learn_app/Controllers/home_controller.dart';
import 'package:my_learn_app/Controllers/onboarding_controller.dart';
import 'package:my_learn_app/Models/home_info.dart';
import 'package:get/state_manager.dart';
import 'package:my_learn_app/Providers/favourite_provider.dart';
import 'package:share/share.dart';
import 'package:provider/provider.dart';
import 'favourite_quotes_page.dart';
import 'premium_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.put(HomeController());
  final _controller = OnboardingController();

  List<int> selectedQuote = [];

  List<AffirmationList> affirmationList = [];

  @override
  void initState() {
    super.initState();
    controller.readJsonApi("https://deveffocess.github.io/sample.json");
    loadAffirmations();
  }

  void loadAffirmations() async {
    // get affirmation data from database and set the state
    List<AffirmationList> data = await controller.getAllAffirmations();
    setState(() {
      affirmationList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              tileMode: TileMode.mirror,
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [Colors.red, Colors.white])),
      child: FutureBuilder<List<AffirmationList>>(
        future: controller.getAllAffirmations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
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
            return Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: EdgeInsets.only(top: 29, right: 10),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 8.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          primary: Colors.black),

                      onPressed: () => (controller.goToPremium(context)),
                      icon: const Icon(
                        Icons.workspace_premium,
                        size: 20.0,
                      ),
                      label: Text('Premium'), // <-- Text
                    ),
                  ),
                ),
                PageView.builder(
                  key: PageStorageKey('affirmationPageView'),
                  scrollDirection: Axis.vertical,
                  itemCount: affirmationList.length,
                  itemBuilder: (context, index) {
                    final affirmation =
                        affirmationList[index].affirmation ?? '';
                    final aff_id = affirmationList[index].id ?? 0;
                    final aff_is_like = affirmationList[index].is_like == 1;
                    return Stack(
                      children: [
                        Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  affirmation,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 24),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                              ]),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: EdgeInsets.all(100),
                            // height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                    controller.updateAffirmationFavouriteStatus(
                                      aff_id,
                                      aff_is_like,
                                      () {
                                        setState(() {
                                          AffirmationList affirmation =
                                              affirmationList.firstWhere(
                                                  (element) =>
                                                      element.id == aff_id);
                                          affirmation.is_like =
                                              !aff_is_like ? 1 : 0;
                                        });
                                      },
                                    );

                                    print(aff_is_like);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
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
                              primary: Colors.black),

                          onPressed: () => {controller.goToCatagory(context)},
                          icon: const Icon(
                            Icons.grid_view_outlined,
                            size: 24.0,
                          ),
                          label: Text('catagories'), // <-- Text
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 8.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              primary: Colors.black),

                          onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FavouritePage()))
                          },
                          icon: const Icon(
                            Icons.bookmark,
                            size: 20.0,
                          ),
                          label: Text('Bookmark'), // <-- Text
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    ));
  }
}
