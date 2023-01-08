import 'package:flutter/material.dart';
import 'package:device_features/Models/place.dart';
import 'dart:io';
import 'package:device_features/Helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = Place(DateTime.now().toString(), pickedTitle,
        PlaceLocation(0, 0, ''), pickedImage);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }

  Future<void> fetchAndSetProducts() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map((item) =>
            Place(item['id'], item['title'], item['loc'], File(item['image'])))
        .toList();
    notifyListeners();
  }
}
