import 'dart:io';

import 'package:great_places/models/place_location.dart';

class Place {
  final int? id;
  final String title;
  final String description;
  final String writer;
  final PlaceLocation location;
  final File image;
  final DateTime createdAt;

  Place({
    this.id,
    required this.title,
    required this.description,
    required this.writer,
    required this.location,
    required this.image,
    required this.createdAt,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        writer: json["writer"],
        location: json["location"],
        image: json["image"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "location": location,
        "image": image,
        "createdAt": createdAt,
      };
}
