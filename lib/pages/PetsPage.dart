import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import the Provider package
import '../components/PetCard.dart';
import '../models/data.dart';

class PetsPage extends StatefulWidget {
  @override
  _PetsPageState createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {
  @override
  void initState() {
    super.initState();

    Provider.of<PetProvider>(context, listen: false).fetchAndSetPets();
  }

  @override
  Widget build(BuildContext context) {
    List<Pet> pets = Provider.of<PetProvider>(context).pets;

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
}
