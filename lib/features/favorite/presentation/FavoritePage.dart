import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/PetCard.dart';
import '../../common/data.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        /// Favourite
        Expanded(
          child: Consumer<PetProvider>(
            builder: (context, petProvider, _) {
              List<Pet> favoritePets = petProvider.favoritePets;

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: favoritePets.length,
                itemBuilder: (BuildContext context, index) {
                  return PetCard(pet: favoritePets[index]);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
