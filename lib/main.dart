import 'package:flutter/material.dart';
import 'package:great_places/states/great_places.dart';
import 'package:provider/provider.dart';

import './screens/places_list_screen.dart';
import './screens/add_place_screen.dart';
import './screens/place_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GreatPlaces>(
      create: (context) => GreatPlaces(),
      child: MaterialApp(
          title: 'Great Places',
          theme: ThemeData(
            primarySwatch: Colors.grey,
            appBarTheme: AppBarTheme(color: Colors.indigo.shade500),
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: Colors.cyan.shade400),
          ),
          home: PlacesListScreen(),
          routes: {
            AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
            PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
          }),
    );
  }
}
