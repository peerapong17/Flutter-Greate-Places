import 'package:flutter/material.dart';
import 'package:great_places/components/place_card.dart';
import 'package:great_places/states/great_places.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: Center(
                  child: const Text('Got no places yet, start adding some!'),
                ),
                builder: (ctx, greatPlaces, ch) {
                  return greatPlaces.items.length <= 0
                      ? ch!
                      : GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          padding: EdgeInsets.all(10),
                          childAspectRatio: 2 / 2.5,
                          children: greatPlaces.items.map(
                            (e) {
                              var index = greatPlaces.items.indexOf(e);
                              var place = greatPlaces.items[index];
                              return placeCard(context, place);
                            },
                          ).toList(),
                        );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
