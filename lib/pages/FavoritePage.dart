import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/PetCard.dart';
import '../models/data.dart';

class FavoritePage extends StatelessWidget {
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
        //TODO: handle logic of getting favorites only

        /// pet need help
        Text("Pets that need help"),
        Expanded(
          child: Consumer<PetProvider>(
            builder: (context, petProvider, _) {
              List<Pet> favoritePets = petProvider.pets;

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
