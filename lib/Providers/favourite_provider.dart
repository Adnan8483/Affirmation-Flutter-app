import 'package:flutter/foundation.dart';

class FavouriteItemProvider extends ChangeNotifier {
  List<int> _selected = [];

  List<int> get selected => _selected;

  void addItems(int value) {
    _selected.add(value);
    notifyListeners();
  }

  void removeItems(int value) {
    _selected.remove(value);
    notifyListeners();
  }
}
