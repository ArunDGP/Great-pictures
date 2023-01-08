import 'package:flutter/material.dart';
import 'Screens/places_list_screen.dart';
import 'Screens/add_place_screen.dart';
import 'Providers/great_places.dart';
import 'package:provider/provider.dart';

void main() =>
    runApp(ChangeNotifierProvider.value(value: GreatPlaces(), child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
                secondary: Colors.amber, primary: Colors.purpleAccent)),
        routes: {AddPlaceScreen.routeName: (ctx) => AddPlaceScreen()},
        home: PlacesListScreen());
  }
}
