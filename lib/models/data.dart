import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:swe463_project/models/UserProvider.dart';
import 'package:swe463_project/utilities/encode_decode.dart';

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
  late final bool adopted;
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

class PetProvider extends ChangeNotifier {
  List<Pet> _pets = [];

  List<Pet> get pets {
    return [..._pets];
  }

  List<Pet> get adoptedPets {
    return _pets.where((pet) => pet.adopted && pet.user_id ==  UserProvider().user?.id).toList();
  }

  List<Pet> get reportedPets {
    return _pets.where((pet) => !pet.adopted && pet.user_id ==  UserProvider().user?.id).toList();
  }

  Future<void> fetchAndSetPets() async {
    final url = Uri.parse('http://localhost:3300/pets');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      final loadedPets = extractedData['data'];

      loadedPets.forEach((pet) async {
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
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<bool> addPet(Pet pet) async {
    final url = Uri.parse('http://localhost:3300/pets');
    try {
      final response = await http.post(url,
          body:
              await jsonEncode({'pet': await pet.toJson(), 'uid': pet.user_id}),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) return true;
      return false;
    } catch (error) {
      print("err: $error");
      throw (error);
    }
  }

  Future<bool> toggleFavourite(Pet pet) async {
    // FIXME: add endpoint in backend
    // FIXME: fix code
    final url = Uri.parse('http://localhost:3300/pets');
    try {
      final response = await http.put(url,
          body: jsonEncode(pet), headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) return true;
      return false;
    } catch (error) {
      throw (error);
    }
  }

  Future<bool> toggleAdopted(Pet pet) async {
    // FIXME: add endpoint in backend /// Done.. did not change them
    // FIXME: fix code // Done
    final url = Uri.parse('http://localhost:3300/pets');
    try {
      final response = await http.put(url,
          body: jsonEncode({
            'uid': pet.user_id,
            'petId': pet.id,
            'pet': pet,
          }),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        pet.adopted = !pet.adopted;

        notifyListeners();
        return true;
      }
      return false;
    } catch (error) {
      throw (error);
    }
  }
}
