import 'dart:io';

import 'package:great_places/models/place_location.dart';



class Place {
  final int? id;
  final String title;
  final PlaceLocation location;
  final File image;

  Place({
    this.id,
    required this.title,
    required this.location,
    required this.image,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        id: json["id"],
        title: json["title"],
        location: json["location"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "location": location,
        "image": image,
      };
}
