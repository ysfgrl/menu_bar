

import 'package:flutter/cupertino.dart';
import 'package:menu_bar/models.dart';

class MenuBarController extends ChangeNotifier{
  MenuBarController({
    int initialIndex = 0,
    required List<BarItem> items,
  }) : assert(initialIndex >= 0),
        assert(items.isNotEmpty && initialIndex < items.length),
        _items = items, _index = initialIndex,
        _selectedItem = items[initialIndex];

  final List<BarItem> _items;
  BarItem getItem(int index) => _items[index];
  List<BarItem> getItems() => _items;

  BarItem _selectedItem;
  BarItem get selectedItem => _selectedItem;
  set selectedItem(BarItem item){
    _index = _items.indexOf(item);
    _selectedItem= item;
    notifyListeners();
  }

  int get index => _index;
  int _index;
  set index(int value) {
    _selectedItem = _items[value];
    _index = value;
    notifyListeners();
  }

}