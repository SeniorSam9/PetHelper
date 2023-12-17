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
  bool adopted;
  final String description;
  final String contact;
  String urgency;

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
  final UserProvider _userProvider;

  PetProvider(this._userProvider);

  List<Pet> _pets = [];
  List<Pet> _favoritePets = [];

  List<Pet> get pets {
    return [..._pets];
  }

  List<Pet> get favoritePets {
    return [..._favoritePets];
  }

  List<Pet> get adoptedPets {
    String? userId = _userProvider.user?.id;

    print("user id is: $userId");

    return _pets.where((pet) => pet.adopted && pet.user_id == userId).toList();
  }

  List<Pet> get reportedPets {
    String? userId = _userProvider.user?.id;
    return _pets.where((pet) => !pet.adopted && pet.user_id == userId).toList();
  }

  Future<void> fetchAndSetPets() async {
    final url = Uri.parse('http://localhost:3300/pets');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      final loadedPets = extractedData['data'];

      _pets = [];

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
      _pets.add(pet) ;
      final response = await http.post(url,
          body:
              await jsonEncode({'pet': await pet.toJson(), 'uid': pet.user_id}),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200){
        notifyListeners();
        return true;
      }
      else{
        _pets.remove(pet) ;
        notifyListeners() ;
        return false;
      }
    } catch (error) {
      throw (error);
    }
  }

  Future<void> fetchAndSetFavoritePets() async {
    String? userId = _userProvider.user?.id;

    final url = Uri.parse('http://localhost:3300/pets/favorites/$userId');

    _favoritePets = [];
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      final favoritePetIds = extractedData['data'];

      List<String> result = [];
      favoritePetIds
          .forEach((element) => result.add(element['petId'].toString()));

      for (Pet pet in _pets) {
        if (result.contains(pet.id)) {
          _favoritePets.add(pet);
        }
      }
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<bool> toggleFavourite(Pet pet) async {
    try {
      if (_favoritePets.contains(pet)) {
        _favoritePets.remove(pet);
        final url = Uri.parse('http://localhost:3300/pets/favorite');
        final response = await http.delete(url,
            body: jsonEncode({
              'petId': pet.id,
              'userId': _userProvider.user?.id,
            }),
            headers: {'Content-Type': 'application/json'});

        if (response.statusCode == 200) {
          notifyListeners();
          return false;
        }
      } else {
        _favoritePets.add(pet);
        final url = Uri.parse('http://localhost:3300/pets/favorite');
        final response = await http.post(url,
            body: jsonEncode({
              'petId': pet.id,
              'userId': _userProvider.user?.id,
            }),
            headers: {'Content-Type': 'application/json'});

        if (response.statusCode == 200) {
          notifyListeners();
          return false;
        }
      }
      notifyListeners();
      return true;
    } catch (error) {
      throw (error);
    }
  }

  Future<bool> toggleAdopted(Pet pet) async {
    pet.adopted = !pet.adopted;
    final url = Uri.parse('http://localhost:3300/pets');
    try {
      final response = await http.put(url,
          body: jsonEncode({
            'uid': pet.user_id,
            'petId': pet.id,
            'pet': await pet.toJson(),
          }),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        notifyListeners();
        return true;
      }
      pet.adopted = !pet.adopted;
      return false;
    } catch (error) {
      throw (error);
    }
  }
}
