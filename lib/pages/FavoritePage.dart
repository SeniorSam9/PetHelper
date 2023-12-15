import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// search
        SearchBar(
          trailing: [
            IconButton(
              icon: Icon(Icons.search_outlined),
              onPressed: () {
                // TODO: Handle search
              },
            )
          ].toSet(),
        ),
        //TODO : handle logic of getting favorites only

        /// pet need help
        Text("Pets that need help"),
        Expanded(child: Text("list of favorite pets")),
      ],
    );
  }
}
