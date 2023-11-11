import 'package:flutter/material.dart';

class CertainPetRoute extends StatelessWidget {
  final String petName;

  const CertainPetRoute({required this.petName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Details'),
      ),
      body: Center(
        child: Text('Details for $petName'),
      ),
    );
  }
}
