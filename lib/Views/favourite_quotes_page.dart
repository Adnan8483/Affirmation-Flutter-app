import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:my_learn_app/Controllers/home_controller.dart';
import 'package:my_learn_app/Models/home_info.dart';
import 'package:my_learn_app/Providers/favourite_provider.dart';
import 'package:my_learn_app/Views/home_page.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final favouriteItemProvider = Provider.of<FavouriteItemProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          'Bookmark',
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_img/bg_img_2.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<List<AffirmationList>>(
          future: controller.getFavouriteAffirmation(),
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
                  affirmationList.length > 0
                      ? PageView.builder(
                          key: PageStorageKey('affirmationPageView'),
                          scrollDirection: Axis.vertical,
                          itemCount: affirmationList.length,
                          itemBuilder: (context, index) {
                            final affirmation =
                                affirmationList[index].affirmation ?? '';
                            final aff_id = affirmationList[index].id ?? 0;
                            final aff_is_like =
                                affirmationList[index].is_like == 1;
                            print(aff_is_like);
                            return Stack(
                              children: [
                                Center(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                      affirmationList
                                                          .firstWhere(
                                                              (element) =>
                                                                  element.id ==
                                                                  aff_id);
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
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Image.asset(
                                  "assets/images/warning_logo.png",
                                  height: 130,
                                  width: 130,
                                ),
                              ),
                              Text(
                                "You haven't added any affirmations to your favorites yet. Browse through our collection and find some that inspire you.",
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
