import 'package:flutter/material.dart';

class PetDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Details'),
      ),
      body: Center(
        child: Card(
          elevation: 4.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.pets, size: 50),
                title: Text('Type: Cat'),
                subtitle: Text('Priority: Low\nLocation: Hajar, Dhahran'),
              ),
              Text(
                'Title: sleepy cat',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Container(
                height: 200.0,
                child: Ink.image(
                  image: AssetImage(''),
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                'CONTACT ME',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                icon: Icon(Icons.favorite_border),
                color: Colors.red,
                onPressed: () {/* ... */},
              ),
              Text(
                'Description: this cat always sleep i want to ensure she eats instead of sleeping only etc.',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}