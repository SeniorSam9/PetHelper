import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swe463_project/pages/PetsPage.dart';
import '../models/data.dart';
import '../routes/CertainPetRoute.dart';

class ListOfPets extends StatefulWidget {
  @override
  _ListOfPetsState createState() => _ListOfPetsState();
}

class _ListOfPetsState extends State<ListOfPets> {
  @override
  void initState() {
    super.initState();
    // Fetch pets data when the widget is initialized
      Provider.of<PetProvider>(context, listen: false).fetchAndSetPets();
  }

  @override
  Widget build(BuildContext context) {

    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      // itemCount: pets.length,
      itemCount: 6,
      itemBuilder: (context, index) {
        // var pet = pets[index];
        return PetsPage();

      },
    );
  }
}
