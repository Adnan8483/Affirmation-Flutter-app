import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_learn_app/Controllers/categories_controller.dart';

class CatagoriesPage extends StatelessWidget {
  final controller = CategoriesController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    tileMode: TileMode.mirror,
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: [Colors.red, Colors.white])),
            child: MasonryGridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: controller.category_title.length,
                padding: EdgeInsets.all(12),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.white54,
                      child: Center(
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(controller.category_title[index])),
                      ),
                    ),
                  );
                })),
      ),
    );
  }
}
