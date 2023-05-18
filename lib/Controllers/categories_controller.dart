import 'package:get/state_manager.dart';
import 'package:my_learn_app/Models/home_info.dart';
import 'package:sqflite/sqflite.dart';
import 'package:my_learn_app/Models/categories_info.dart';

class CategoriesController {
  List<Category> category_title = [
    Category(title: "Random", value: "random"),
    Category(title: "Self Love", value: "self-love"),
    Category(title: "Positive Thinking", value: "positive-thinking"),
    Category(title: "Self Care", value: "self-care"),
    Category(title: "Gratitude", value: "gratitude"),
  ];
}
