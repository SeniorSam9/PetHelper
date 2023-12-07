import 'package:flutter/material.dart';
import 'package:swe463_project/components/ListOfPets.dart';

class PetsPage extends StatefulWidget {
  @override
  _PetsPageState createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {
  @override
  Widget build(BuildContext context) {
    return ListOfPets();
  }
}
