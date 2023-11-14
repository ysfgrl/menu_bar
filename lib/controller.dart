

import 'package:flutter/cupertino.dart';
import 'package:menu_bar/models.dart';

class MenuBarController extends ChangeNotifier{
  MenuBarController({
    int initialIndex = 0,
    required List<BarItem> items,
  }) : assert(initialIndex >= 0),
        assert(items.isNotEmpty && initialIndex < items.length),
        _items = items, _index = initialIndex;

  late List<BarItem> _items;
  BarItem getItem(int index) => _items[index];
  List<BarItem> getItems() => _items;


  BarItem getSelectedItem(){
    return _items[_index];
  }

  int get index => _index;
  int _index;
  set index(int value) {
    _index = value;
    notifyListeners();
  }

  void setId(int id){
    for (final (index, item) in _items.indexed) {
      if(item.id == id) {
        _index = index;
        notifyListeners();
        break;
      }
    }
  }

  void updateItems(List<BarItem> items){
    if(_items.length != items.length){
      _items = items;
      if(_index >= _items.length){
        _index = 0;
      }
      notifyListeners();
    }
  }


}