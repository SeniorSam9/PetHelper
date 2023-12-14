import 'package:flutter/material.dart';

class ListOfPets extends StatefulWidget {
  @override
  _ListOfPetsState createState() => _ListOfPetsState();
}

class _ListOfPetsState extends State<ListOfPets> {
  @override
  void initState() {
    super.initState();
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
      itemCount: 6, // Replace with the number of pets or use pets.length
      itemBuilder: (context, index) {
        // Replace the Card widget with your desired widget or pet data
        return Card(
          child: Text("Something"),
        );
      },
    );
  }
}