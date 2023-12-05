import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utilities/locationFinder.dart';
import '../utilities/imagePicker.dart';
import '../components/CustomRadioButtonForPets.dart';
import '../components/CustomRadioButton.dart';

class FormRoute extends StatefulWidget {
  @override
  _FormRouteState createState() => _FormRouteState();
}

class _FormRouteState extends State<FormRoute> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double _lng = 0;
  double _lat = 0;

  String _urgentValue = 'Urgent';
  String _petKind = 'Dog';

  GlobalKey _buttonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Page'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// title
                SizedBox(height: 16.0),
                Text("Add title", style: Theme.of(context).textTheme.bodyLarge),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                      hintText: 'Write title here...',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor))),
                ),

                /// pet kind
                SizedBox(height: 16.0),
                Text("What type of pet you found?",
                    style: Theme.of(context).textTheme.bodyLarge),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CustomRadioButtonForPets(
                          value: 'Dog',
                          imageURL: 'assets/images/dog.png',
                          groupValue: _petKind,
                          onChanged: (value) {
                            setState(() {
                              _petKind = value;
                            });
                          },
                        ),
                        CustomRadioButtonForPets(
                          value: 'Cat',
                          imageURL: 'assets/images/cat.png',
                          groupValue: _petKind,
                          onChanged: (value) {
                            setState(() {
                              _petKind = value;
                            });
                          },
                        ),
                        CustomRadioButtonForPets(
                          value: 'bird',
                          imageURL: 'assets/images/bird.png',
                          groupValue: _petKind,
                          onChanged: (value) {
                            setState(() {
                              _petKind = value;
                            });
                          },
                        ),
                        CustomRadioButtonForPets(
                          value: 'Hams',
                          imageURL: 'assets/images/hams.png',
                          groupValue: _petKind,
                          onChanged: (value) {
                            setState(() {
                              _petKind = value;
                            });
                          },
                        ),
                        CustomRadioButtonForPets(
                          value: 'Fish',
                          imageURL: 'assets/images/fish.png',
                          groupValue: _petKind,
                          onChanged: (value) {
                            setState(() {
                              _petKind = value;
                            });
                          },
                        ),
                      ],
                    )),

                /// urgent status
                SizedBox(height: 16.0),
                Text("How urgent is the pet condition ?",
                    style: Theme.of(context).textTheme.bodyLarge),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomRadioButton(
                      value: 'Not urgent',
                      groupValue: _urgentValue,
                      onChanged: (value) {
                        setState(() {
                          _urgentValue = value;
                        });
                      },
                    ),
                    CustomRadioButton(
                      value: 'Urgent',
                      groupValue: _urgentValue,
                      onChanged: (value) {
                        setState(() {
                          _urgentValue = value;
                        });
                      },
                    ),
                    CustomRadioButton(
                      value: 'Very urgent',
                      groupValue: _urgentValue,
                      onChanged: (value) {
                        setState(() {
                          _urgentValue = value;
                        });
                      },
                    ),
                  ],
                ),

                /// location lat & lng
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Spacer(),
                    ElevatedButton(
                      child: Row(
                        children: [
                          Text("Get my location"),
                          Icon(Icons.location_on_outlined)
                        ],
                      ),
                      onPressed: () async {
                        var locationData = await retrieveGPSLocation();
                        if (locationData?['latitude'] == 0 &&
                            locationData?['longitude'] == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Unable to get location")));
                          return;
                        }
                        setState(() {
                          _lat = locationData!['latitude']!;
                          _lng = locationData['longitude']!;
                        });
                      },
                    ),
                    Spacer(),
                  ],
                ),
                Text(_lat.toString()),
                Text(_lng.toString()),

                /// upload
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.all(8.0),
                  height: 64,
                  child: ElevatedButton(
                    key: _buttonKey,
                    child: Text("Upload pet image"),
                    onPressed: () async {
                      XFile? selectedImage = await pickImages();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Selected Image'),
                            content: Container(
                                width: double.maxFinite,
                                child: Image.file(File(selectedImage!.path))),
                            actions: [
                              TextButton(
                                child: Text('Confirm'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Retry'),
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  (_buttonKey.currentWidget as ElevatedButton)
                                      .onPressed!();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),

                /// description
                SizedBox(height: 16.0),
                Text("Add description",
                    style: Theme.of(context).textTheme.bodyLarge),
                TextFormField(
                  minLines: 3,
                  maxLines: 4,
                  controller: _descriptionController,
                  decoration: InputDecoration(
                      hintText: 'Write addition description here ...',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor))),
                ),

                /// buttons
                SizedBox(height: 16.0),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 48.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          // TODO: add post logic
                          onPressed: () {},
                          child: Text("Post"),
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(32.0))),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel"),
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(32.0)))
                    ],
                  ),
                ),

                /// aux
                SizedBox(height: 96.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
