import 'package:flutter/material.dart';
import 'package:swe463_project/routes/FormRoute.dart';
import '../components/ListOfPets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text('Home Page'),
        ),
        Center(
          child: ElevatedButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FormRoute(),
                ),
              );
            },
            child: Text("Post new"),
          ),
        ),
        Expanded(
          child: ListOfPets(),
        ),
      ],
    );
  }
}
