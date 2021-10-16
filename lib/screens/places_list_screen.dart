import 'package:flutter/material.dart';
import 'package:great_places/states/great_places.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import './place_detail_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
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
                      // : ListView.builder(
                      //     itemCount: greatPlaces.items.length,
                      //     itemBuilder: (ctx, i) => ListTile(
                      //       leading: CircleAvatar(
                      //         backgroundImage: FileImage(
                      //           greatPlaces.items[i].image,
                      //         ),
                      //       ),
                      //       title: Text(greatPlaces.items[i].title),
                      //       subtitle:
                      //           Text(greatPlaces.items[i].location.address!),
                      //       onTap: () {
                      //         Navigator.of(context).pushNamed(
                      //           PlaceDetailScreen.routeName,
                      //           arguments: greatPlaces.items[i].id,
                      //         );
                      //       },
                      //     ),
                      //   );
                      : GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          padding: EdgeInsets.all(10),
                          childAspectRatio: 2 / 2.5,
                          children: greatPlaces.items.map(
                            (e) {
                              var index = greatPlaces.items.indexOf(e);
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    PlaceDetailScreen.routeName,
                                    arguments: greatPlaces.items[index].id,
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        // Expanded(
                                        //   child: CircleAvatar(
                                        //     backgroundImage: FileImage(
                                        //       greatPlaces.items[index].image,
                                        //     ),
                                        //   ),
                                        // ),
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            child: Image.file(
                                              greatPlaces.items[index].image,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          greatPlaces.items[index].title,
                                          style: TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          greatPlaces
                                              .items[index].location.address!,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        );
                },
              ),
      ),
    );
  }
}
