import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/PetCard.dart';
import '../../common/data.dart'; // Import the Provider package


class PetsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PetProvider>(
        builder: (context, petProvider, _) {
          List<Pet> pets = petProvider.availablePets;

          return GridView.builder(
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: pets.length,
            itemBuilder: (context, index) {
              return PetCard(pet: pets[index]);
            },
          );
        }
    );
  }
}
