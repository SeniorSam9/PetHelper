import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum AnimalType { cat, dog, fish, bird, other }

enum Urgency { nonUrgent, Urgent, veryUrgent }

extension UrgencyExtension on Urgency {
  String get stringValue {
    switch (this) {
      case Urgency.nonUrgent:
        return "Non Urgent";
      case Urgency.Urgent:
        return "Urgent";
      case Urgency.veryUrgent:
        return "Very Urgent";
    }
  }
}

class Pet {
  final String name;
  final String image;
  final String location;
  final String id;
  late final bool favorite;
  final AnimalType animaltype;

  final bool adopted;

  final String describtion;

  final Urgency urgency;

  Pet(
      {required this.adopted,
      required this.animaltype,
      required this.describtion,
      required this.name,
      required this.image,
      required this.location,
      required this.id,
      required this.favorite,
      required this.urgency});

  // user clicks the favorite button
  void toggleFavorite(String id) {
    final petIndex = pets.indexWhere((pet) => pet.id == id);
    pets[petIndex].favorite = !pets[petIndex].favorite;
  }

// make a provider class for pets using change notifier

  // fromJson() method to convert JSON data to a Pet object
  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
        adopted: json['adopted'],
        animaltype: AnimalType.values[json['animaltype']],
        describtion: json['describtion'],
        name: json['name'],
        image: json['image'],
        location: json['location'],
        id: json['_id'],
        favorite: json['favorite'],
        urgency: Urgency.values[json['urgency']]);
  }
}

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
      pets.forEach((pet) {
        loadedPets.add(Pet(
            adopted: pet['adopted'],
            animaltype: AnimalType.values[pet['animaltype']],
            describtion: pet['describtion'],
            name: pet['name'],
            image: pet['image'],
            location: pet['location'],
            id: pet['id'],
            favorite: pet['favorite'],
            urgency: Urgency.values[pet['urgency']]
        ));
      });
      print(loadedPets);
      _pets = loadedPets;
    } catch (error) {
      throw (error);
    }
  }
}

Future<List<Pet>> getAllPets() async {
  try {
    var response = await http.get(
        Uri.parse(
          'http://localhost:3300/pets',
        ),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      var petsJson = jsonDecode(response.body);
      return petsJson.map((pet) => Pet.fromJson(pet)).toList();
    } else {
      throw Exception('Failed to load pets');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

final List<Pet> pets = [
  Pet(
      name: 'Fluffy',
      image: './assets/images/sad dog.png',
      location: 'Dammam 4km',
      favorite: true,
      id: '1',
      adopted: false,
      animaltype: AnimalType.dog,
      describtion: "fluffy need help call me on -xxx",
      urgency: Urgency.nonUrgent),
  Pet(
      name: 'Whiskers',
      image: './assets/images/street hamster .png',
      location: 'Riyadh 2km',
      favorite: false,
      id: '2',
      adopted: false,
      animaltype: AnimalType.other,
      describtion: "Hamster need help call me on -xxx",
      urgency: Urgency.nonUrgent),
  Pet(
      name: 'Spot',
      image: './assets/images/street cat.png',
      location: 'Jeddah 3km',
      favorite: false,
      id: '3',
      adopted: false,
      animaltype: AnimalType.cat,
      describtion: "Spot need help call me on -xxx",
      urgency: Urgency.nonUrgent),
  Pet(
      name: 'Mittens',
      image: './assets/images/street cat.png',
      location: 'Khobar 1km',
      favorite: false,
      id: '4',
      adopted: true,
      animaltype: AnimalType.cat,
      describtion: "mittens need help call me on -xxx",
      urgency: Urgency.nonUrgent),
  Pet(
      name: 'Fish need help',
      image: './assets/images/injured fish.png',
      location: 'Dammam 4km',
      favorite: false,
      id: '5',
      adopted: false,
      animaltype: AnimalType.fish,
      describtion: "This fish need help call me on -xxx",
      urgency: Urgency.nonUrgent),
  Pet(
      name: 'حالة انسانية طير في شمال الرياض',
      image: './assets/images/injured bird.png',
      location: 'Riyadh 2km',
      favorite: false,
      id: '6',
      adopted: false,
      animaltype: AnimalType.dog,
      describtion: "Spike need help call me on -xxx",
      urgency: Urgency.nonUrgent),
];
