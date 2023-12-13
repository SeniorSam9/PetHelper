import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swe463_project/utilities/encode_decode.dart';

List<String> animalType = ['cat', 'dog', 'fish', 'bird', 'other'];

List<String> urgency = ['non urgent', 'urgent', 'very urgent'];

class Pet {
  late final String? id;
  late final String user_id;
  final String title;
  XFile image;
  String? imageEncoded;
  final String city;
  final double lat;
  final double lng;
  final String animal_type;
  final bool adopted;
  final String description;
  final String contact;
  final String urgency;

  Pet({
    this.id,
    required this.user_id,
    required this.title,
    required this.image,
    required this.city,
    required this.lat,
    required this.lng,
    required this.animal_type,
    required this.adopted,
    required this.description,
    required this.contact,
    required this.urgency,
  });

  // fromJson() method to convert JSON data to a Pet object
  factory Pet.fromJSON(Map<String, dynamic> json) {
    return Pet(
      id: json['id'],
      user_id: json['user_id'],
      title: json['title'],
      image: json['image'],
      city: json['city'],
      lat: json['lat'],
      lng: json['lng'],
      animal_type: json['animal_type'],
      adopted: json['adopted'],
      description: json['description'],
      contact: json['contact'],
      urgency: json['urgency'],
    );
  }

  Future<Map<String, dynamic>> toJson() async {
    return {
      'id': id,
      'user_id': user_id,
      'title': title,
      'image': await encodeImage(image),
      'city': city,
      'lat': lat,
      'lng': lng,
      'animal_type': animal_type,
      'adopted': adopted,
      'description': description,
      'contact': contact,
      'urgency': urgency,
    };
  }
}

// user clicks the favorite button
// void toggleFavorite(String id) {
//   final petIndex = pets.indexWhere((pet) => pet.id == id);
//   pets[petIndex].favorite = !pets[petIndex].favorite;
// }

// make a provider class for pets using change notifier
// make a pet provider class
class PetProvider extends ChangeNotifier {
  List<Pet> _pets = [];

  List<Pet> get pets {
    return [..._pets];
  }

  Future<void> fetchAndSetPets() async {
    final url = Uri.parse('http://10.0.2.2:3300/pets');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      final pets = extractedData['data'];
      print(pets);
      // make a list of pets as a Pet object
      final List<Pet> loadedPets = [];
      pets.forEach((pet) async {
        _pets.add(Pet(
          id: pet['id'],
          user_id: pet['user_id'],
          title: pet['title'],
          image: await decodeImage(pet['image']),
          city: pet['city'],
          lat: pet['lat'],
          lng: pet['lng'],
          animal_type: pet['animal_type'],
          adopted: pet['adopted'],
          description: pet['description'],
          contact: pet['contact'],
          urgency: pet['urgency'],
        ));
      });
      print(loadedPets);
      _pets = loadedPets;
    } catch (error) {
      throw (error);
    }
  }

  Future<bool> addPet(Pet pet) async {
    // pet.imageEncoded = await encodeImage(pet.image);
    print("-----------------");
    // print(pet);
    print("-----------------");

    // print(await jsonEncode(await pet.toJson()));
    print("-----------------");

    final url = Uri.parse('http://localhost:3300/pets');
    try {
      final response = await http.post(url,
          body:  await jsonEncode({'pet': await pet.toJson(), 'uid': pet.user_id}),
          headers: {'Content-Type': 'application/json'});
      print('RESP: $response');
      if (response.statusCode == 201) return true;
      return false;
    } catch (error) {
      print("err: $error");
      throw (error);
    }
  }

  Future<bool> toggleFavourite(Pet pet) async {
    // FIXME: add endpoint in backend
    // FIXME: fix code
    final url = Uri.parse('http://10.0.2.2:3300/pets/');
    try {

      final response = await http.put(url,
          body: jsonEncode(pet), headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 201) return true;
      return false;
    } catch (error) {
      throw (error);
    }
  }

  Future<bool> toggleAdopted(Pet pet) async {
    // FIXME: add endpoint in backend
    // FIXME: fix code
    final url = Uri.parse('http://10.0.2.2:3300/pets/');
    try {
      final response = await http.put(url,
          body: jsonEncode(pet), headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 201) return true;
      return false;

    } catch (error) {
      throw (error);
    }
  }
}


final List<Pet> pets = [
];
