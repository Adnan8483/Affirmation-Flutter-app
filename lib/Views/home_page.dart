import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:my_learn_app/Controllers/home_controller.dart';
import 'package:my_learn_app/Models/home_info.dart';
import 'package:get/state_manager.dart';
import 'package:my_learn_app/Providers/favourite_provider.dart';
import 'package:share/share.dart';
import 'package:provider/provider.dart';
import 'favourite_quotes_page.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  List<int> selectedQuote = [];

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
        child: FutureBuilder<HomeInfo>(
          future: controller
              .readJsonApi("https://deveffocess.github.io/sample.json"),
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
              final homeInfo = snapshot.data!;
              final affirmationList = homeInfo.affirmationList ?? [];
              return Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 8.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            primary: Colors.black),

                        onPressed: () => print("Premium pressed!"),
                        icon: const Icon(
                          Icons.workspace_premium,
                          size: 20.0,
                        ),
                        label: Text('Premium'), // <-- Text
                      ),
                    ),
                  ),
                  PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: affirmationList.length,
                    itemBuilder: (context, index) {
                      final affirmation =
                          affirmationList[index]?.affirmation ?? '';
                      final aff_id = affirmationList[index]?.id ?? 0;
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
                                  Consumer<FavouriteItemProvider>(
                                    builder: (context, favouriteProvider, _) =>
                                        IconButton(
                                      iconSize: 30.0,
                                      icon: Icon(favouriteProvider.selected
                                              .contains(aff_id)
                                          ? Icons.favorite_sharp
                                          : Icons.favorite_border),
                                      onPressed: () {
                                        if (favouriteProvider.selected
                                            .contains(aff_id)) {
                                          favouriteProvider.removeItems(aff_id);
                                        } else {
                                          favouriteProvider.addItems(aff_id);
                                        }
                                        print(favouriteProvider.selected);
                                      },
                                    ),
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
      ),
    );
  }
}
