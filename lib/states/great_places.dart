import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:great_places/models/place_location.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class GreatPlaces extends ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  set items(List<Place> items) {
    _items = items;
    notifyListeners();
  }

  Place findById(int id) {
    return items.firstWhere((place) => place.id == id);
  }

  Future<void> addPlace(
    String pickedTitle,
    String pickedDesc,
    String pickedWriter,
    File pickedImage,
    PlaceLocation pickedLocation,
  ) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );
    final newPlace = Place(
      image: pickedImage,
      description: pickedDesc,
      title: pickedTitle,
      writer: pickedWriter,
      location: updatedLocation,
      createdAt: new DateTime.now(),
    );
    items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'title': newPlace.title,
      'description': newPlace.description,
      'writer': newPlace.writer,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address!,
      'createdAt': newPlace.createdAt.toIso8601String(),
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    print(dataList);
    items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            description: item['description'],
            writer: item['writer'],
            image: File(item['image']),
            location: PlaceLocation(
              latitude: item['loc_lat'],
              longitude: item['loc_lng'],
              address: item['address'],
            ),
            createdAt: DateTime.parse(
              item['createdAt'],
            ),
          ),
        )
        .toList();

    notifyListeners();
  }

  Future<void> deletePlace(int id) async {
    await DBHelper.delete('user_places', id);
    items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
