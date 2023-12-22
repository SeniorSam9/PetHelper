import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/PetCard.dart';
import '../../common/data.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int maxPets = 6; // maximum number of pets

  @override
  Widget build(BuildContext context) {
    List<Pet> pets = Provider.of<PetProvider>(context).availablePets;

    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: pets.length > maxPets ? maxPets : pets.length,
              itemBuilder: (context, index) {

                return PetCard(pet: pets[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
