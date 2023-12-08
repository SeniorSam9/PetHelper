enum AnimalType {cat, dog, fish, bird, other}
enum Urgency { nonUrgent, Urgent, veryUrgent}
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
  final AnimalType animaltype ;
  final bool adopted ;
  final String describtion ;
  final Urgency urgency ;

  Pet({
    required this.adopted, required this.animaltype, required this.describtion,
    required this.name,
    required this.image,
    required this.location,
    required this.id,
    required this.favorite,
    required this.urgency
  });
  // user clicks the favorite button
  void toggleFavorite(String id) {
    final petIndex = pets.indexWhere((pet) => pet.id == id);
    pets[petIndex].favorite = !pets[petIndex].favorite;

  }
  // a get pets from backend api
  List<Pet> getPets() {

    return pets;
  }
}
final List<Pet> pets = [
  Pet(
      name: 'Fluffy',
      image: './assets/images/cat.png',
      location: 'Dammam 4km',
      favorite: true,
      id: '1',
      adopted: false,
      animaltype: AnimalType.dog,
      describtion: "fluffy need help call me on -xxx",
      urgency: Urgency.nonUrgent
  ),
  Pet(
      name: 'Whiskers',
      image: './assets/images/cat.png',
      location: 'Riyadh 2km',
      favorite: false,
      id: '2',
      adopted: false,
      animaltype: AnimalType.dog,
      describtion: "Whiskers need help call me on -xxx",
      urgency: Urgency.nonUrgent


  ),

  Pet(
      name: 'Spot',
      image: './assets/images/cat.png',
      location: 'Jeddah 3km',
      favorite: false,
      id: '3',
      adopted: false,
      animaltype: AnimalType.dog,
      describtion: "Spot need help call me on -xxx",
      urgency: Urgency.nonUrgent

  ),
  Pet(
      name: 'Mittens',
      image: './assets/images/fish.png',
      location: 'Khobar 1km',
      favorite: false,
      id: '4',
      adopted: true,
      animaltype: AnimalType.cat,
      describtion: "mittens need help call me on -xxx",
      urgency: Urgency.nonUrgent


  ),
  Pet(
      name: 'Buddy',
      image: './assets/images/dog.png',
      location: 'Dammam 4km',
      favorite: false,
      id: '5',
      adopted: false,
      animaltype: AnimalType.dog,
      describtion: "Buddy need help call me on -xxx",
      urgency: Urgency.nonUrgent

  ),
  Pet(
      name: 'Spike',
      image: './assets/images/injured bird.png',
      location: 'Riyadh 2km',
      favorite: false,
      id: '6',
      adopted: false,
      animaltype: AnimalType.dog,
      describtion: "Spike need help call me on -xxx",
      urgency: Urgency.nonUrgent

  ),
];




