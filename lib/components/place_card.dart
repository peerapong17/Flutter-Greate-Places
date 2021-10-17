import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/screens/place_detail_screen.dart';
import 'package:great_places/states/great_places.dart';
import 'package:provider/provider.dart';

GestureDetector placeCard(BuildContext context, Place place) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamed(
        PlaceDetailScreen.routeName,
        arguments: place.id,
      );
    },
    child: Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: Image.file(
                      place.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: -10,
                    right: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: DropdownButton<String>(
                        icon: Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                        ),
                        items: <String>['Remove'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          Provider.of<GreatPlaces>(context, listen: false)
                              .deletePlace(
                            place.id!,
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              place.title,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              place.location.address!,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
