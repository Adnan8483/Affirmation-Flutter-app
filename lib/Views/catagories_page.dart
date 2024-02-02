import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:my_learn_app/Controllers/categories_controller.dart';
import 'package:my_learn_app/Controllers/home_controller.dart';
import 'package:get/state_manager.dart';

class CatagoriesPage extends StatefulWidget {
  @override
  State<CatagoriesPage> createState() => _CatagoriesPageState();
}

class _CatagoriesPageState extends State<CatagoriesPage> {
  final controller = CategoriesController();
  final HomeController homeController = Get.put(HomeController());

  List<String> _selectedCategories = ["random"];

  @override
  void initState() {
    super.initState();
    homeController.loadSelectedCategories().then((categories) {
      setState(() {
        _selectedCategories = categories;
        print(_selectedCategories.isEmpty);

        if (_selectedCategories.isEmpty) {
          _selectedCategories.add('random');
        }
      });
    });
  }

  void _onCategorySelected(String category) {
    setState(() {
      //Logic for if Random Category is selected then other categories deselect and if other categories are then selected then Random is deselected.
      if (category == 'random') {
        if (_selectedCategories.contains('random')) {
          null;
        } else {
          _selectedCategories.clear();
          _selectedCategories.add('random');
        }
      } else {
        if (_selectedCategories.contains('random')) {
          _selectedCategories.remove('random');
        }
        if (_selectedCategories.contains(category)) {
          _selectedCategories.remove(category);
        } else {
          _selectedCategories.add(category);
        }
      }
    });
  }

  void _onDonePressed(BuildContext context) async {
    // Navigate back to home screen and pass selected categories
    Navigator.pop(context, _selectedCategories);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
          title: const Text('Select Categories',
              style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                // Navigate back to home screen and pass selected categories
                _onDonePressed(context);
              },
              icon: const Icon(Icons.done),
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
                padding: EdgeInsets.only(top: kToolbarHeight),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/background_img/bg_img_2.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: MasonryGridView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: controller.category_title.length,
                    padding: EdgeInsets.all(12),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    gridDelegate:
                        SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      final currentCategory =
                          controller.category_title[index].value;

                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 12,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          child: InkWell(
                            onTap: () {
                              _onCategorySelected(currentCategory);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  begin: Alignment(0, -1),
                                  end: Alignment(0, 1),
                                  colors: _selectedCategories
                                          .contains(currentCategory)
                                      ? <Color>[
                                          Color(0xffdadada),
                                          Color(0xffa0b3b8)
                                        ]
                                      : <Color>[
                                          Color.fromARGB(255, 255, 255, 255),
                                          Color.fromARGB(255, 255, 255, 255)
                                        ],
                                  stops: <double>[0, 1],
                                ),
                              ),
                              height: 100,
                              width: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      child: Text(
                                          controller
                                              .category_title[index].title,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
