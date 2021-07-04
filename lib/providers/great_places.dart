import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_place_app/helpers/db_helper.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(
    String pickedTitle,
    File pickedImage,
    double lat,
    double long,
  ) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: PlaceLocation(
        latitude: lat,
        longitude: long,
        address: 'latitude: $lat, longitude: $long',
      ),
    );
    _items.add(newPlace);
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_long': newPlace.location.longitude,
      'address': newPlace.location.address as String,
    });
    notifyListeners();
  }

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map((d) => Place(
              id: d['id'],
              title: d['title'],
              location: PlaceLocation(
                latitude: d['loc_lat'],
                longitude: d['loc_long'],
                address: d['address'],
              ),
              image: File(d['image']),
            ))
        .toList();
    notifyListeners();
  }
}
