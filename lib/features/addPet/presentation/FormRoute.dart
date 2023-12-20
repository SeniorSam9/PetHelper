import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:swe463_project/features/addPet/presentation/widgets/CustomRadioButton.dart';
import 'package:swe463_project/features/addPet/presentation/widgets/CustomRadioButtonForPets.dart';


import '../../authentication/model/UserProvider.dart';
import '../../common/data.dart';
import '../../common/utilities/getImagePlatform.dart';
import '../model/cityFinder.dart';
import '../model/locationFinder.dart';
import '../model/imagePicker.dart';



class FormRoute extends StatefulWidget {
  @override
  _FormRouteState createState() => _FormRouteState();
}

class _FormRouteState extends State<FormRoute> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _contactController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double _lng = 0;
  double _lat = 0;

  String _urgentValue = 'Urgent';
  String _animal_type = 'Dog';
  late Map<String, double> _locationData;
  XFile? _selectedImage = null;
  String _city = 'Get my location';

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
                SizedBox(height: 8.0),
                TextFormField(
                  controller: _titleController,
                  maxLength: 20,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill in the title';
                    }
                    setState(() {
                      _titleController.text = value;
                    });
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Write title here...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      )),
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
                          groupValue: _animal_type,
                          onChanged: (value) {
                            setState(() {
                              _animal_type = value;
                            });
                          },
                        ),
                        CustomRadioButtonForPets(
                          value: 'Cat',
                          imageURL: 'assets/images/cat.png',
                          groupValue: _animal_type,
                          onChanged: (value) {
                            setState(() {
                              _animal_type = value;
                            });
                          },
                        ),
                        CustomRadioButtonForPets(
                          value: 'Bird',
                          imageURL: 'assets/images/bird.png',
                          groupValue: _animal_type,
                          onChanged: (value) {
                            setState(() {
                              _animal_type = value;
                            });
                          },
                        ),
                        CustomRadioButtonForPets(
                          value: 'Hams',
                          imageURL: 'assets/images/hams.png',
                          groupValue: _animal_type,
                          onChanged: (value) {
                            setState(() {
                              _animal_type = value;
                            });
                          },
                        ),
                        CustomRadioButtonForPets(
                          value: 'Fish',
                          imageURL: 'assets/images/fish.png',
                          groupValue: _animal_type,
                          onChanged: (value) {
                            setState(() {
                              _animal_type = value;
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: Row(
                        children: [
                          Text(_city),
                          Icon(Icons.location_on_outlined)
                        ],
                      ),
                      onPressed: () async {
                        _locationData = (await retrieveGPSLocation())!;
                        if (_locationData['latitude'] == 0 &&
                            _locationData['longitude'] == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Unable to get location")));
                          return;
                        }
                        _city = (await fetchCityFromCoordinates(
                            lat: _locationData['latitude'],
                            lng: _locationData['longitude']))!;
                        if (_city == 'Get my location') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Unable to get location")));
                          return;
                        }

                        setState(() {
                          _lat = _locationData['latitude']!;
                          _lng = _locationData['longitude']!;
                          _city;
                        });
                      },
                    ),
                  ],
                ),

                /// upload
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.all(8.0),
                  height: 64,
                  child: ElevatedButton(
                    key: _buttonKey,
                    style: ElevatedButton.styleFrom(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onPressed: () async {
                      _selectedImage = await pickImages();
                      if (_selectedImage == null) return;
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Selected Image'),
                            content: Container(
                              width: double.maxFinite,
                              child: getImagePlatform(
                                  _selectedImage!.path, context),
                            ),
                            actions: [
                          TextButton(
                          child: Text('Retry'),
                          onPressed: () async {
                          Navigator.of(context).pop();
                          (_buttonKey.currentWidget as ElevatedButton)
                              .onPressed!();
                          },
                          ),
                              TextButton(
                                child: Text('Confirm'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),

                            ],
                          );
                        },
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image),
                        SizedBox(width: 8),
                        Text("Upload pet image"),
                      ],
                    ),
                  ),
                ),

                /// description
                SizedBox(height: 16.0),
                Text("Add description",
                    style: Theme.of(context).textTheme.bodyLarge),
                SizedBox(height: 8.0),
                TextFormField(
                  maxLength: 150,
                  minLines: 3,
                  maxLines: 4,
                  controller: _descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill in the description';
                    }
                    setState(() {
                      _descriptionController.text = value;
                    });
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Write addition description here ...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor))),
                ),

                /// contact
                SizedBox(height: 16.0),
                Text("Add your contact",
                    style: Theme.of(context).textTheme.bodyLarge),
                SizedBox(height: 8.0),
                TextFormField(
                  maxLength: 10,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  controller: _contactController,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length != 10) {
                      return 'Please fill in your contact info.';
                    }
                    setState(() {
                      _contactController.text = value;
                    });
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: '05xxx',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
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
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel"),
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(32.0))),
                      ElevatedButton(
                          // TODO: add post logic
                          onPressed: () async {
                            if (_formKey.currentState!.validate() &&
                                _locationData['latitude'] != 0 &&
                                _locationData['longitude'] != 0 &&
                                _selectedImage != null) {
                              _formKey.currentState!.save();

                              // The form is valid, proceed with POST logic
                              var res = await Provider.of<PetProvider>(context,
                                      listen: false)
                                  .addPet(Pet(
                                user_id: Provider.of<UserProvider>(context, listen: false).user!.id,
                                title: _titleController.text,
                                image: _selectedImage!,
                                city: _city,
                                lat: _lat,
                                lng: _lng,
                                animal_type: _animal_type,
                                adopted: false,
                                description: _descriptionController.text,
                                contact: _contactController.text,
                                urgency: _urgentValue,
                              ));
                              if (res) {
                                await ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Your pet has been added successfully')),
                                );
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('ERROR: try again')),
                                );
                              }
                            }
                          },
                          child: Text("Post"),
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(32.0))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
