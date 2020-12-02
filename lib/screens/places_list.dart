import 'package:flutter/material.dart';
import 'package:flutter_native_features/providers/great_places.dart';
import 'package:flutter_native_features/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yours Places'),
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
                    child: Text('Got no places add some from another route')),
                builder: (ctx, greatplaces, ch) => greatplaces.items.length <= 0
                    ? ch
                    : ListView.builder(
                        itemCount: greatplaces.items.length,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(
                              greatplaces.items[i].image,
                            ),
                          ),
                          title: Text(greatplaces.items[i].title),
                          onTap: () {},
                        ),
                      ),
              ),
      ),
    );
  }
}
