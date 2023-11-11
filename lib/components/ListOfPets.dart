import 'package:flutter/material.dart';

import '../routes/CertainPetRoute.dart';

class ListOfPets extends StatelessWidget {
  final List<String> _pets = [
    'Fluffy',
    'Whiskers',
    'Spot',
    'Mittens',
    'Buddy',
    'Spike',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _pets.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.pets),
          title: Text(_pets[index]),
          trailing: IconButton(
              icon: Icon(Icons.info),
              onPressed: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CertainPetRoute(
                              petName: _pets[index],
                            )));
              }),
        );
      },
    );
  }
}
