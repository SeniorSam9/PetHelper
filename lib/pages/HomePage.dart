import 'package:flutter/material.dart';
import '../components/ListOfPets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Column(
        children: [
          Expanded(child: ListOfPets()),
        ],
      ),
    );
  }
}
