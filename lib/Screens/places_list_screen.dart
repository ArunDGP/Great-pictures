import 'package:flutter/material.dart';
import 'add_place_screen.dart';
import 'package:device_features/Providers/great_places.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Places'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetProducts(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<GreatPlaces>(
                  builder: (ctx, greatPlaces, _) => greatPlaces.items.length <=
                          0
                      ? Center(child: Text('You have not add any places yet!'))
                      : ListView.builder(
                          itemCount: greatPlaces.items.length,
                          itemBuilder: (ctx, i) => ListTile(
                            leading: CircleAvatar(
                              radius: 11,
                              backgroundImage:
                                  FileImage(greatPlaces.items[i].image),
                            ),
                            title: Text(
                              greatPlaces.items[i].title,
                              style: TextStyle(background: Paint()),
                            ),
                            onTap: () {},
                          ),
                        ),
                ),
        ));
  }
}
