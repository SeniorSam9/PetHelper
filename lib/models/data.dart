
class Pet {
  final String name;
  final String image;
  final String location;
  final String id;
  late final bool favorite;

  Pet({
    required this.name,
    required this.image,
    required this.location,
    required this.id,
    required this.favorite,
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
      id: '1'),
  Pet(
      name: 'Whiskers',
      image: './assets/images/cat.png',
      location: 'Riyadh 2km',
      favorite: false,
      id: '2'),
  Pet(
      name: 'Spot',
      image: './assets/images/cat.png',
      location: 'Jeddah 3km',
      favorite: false,
      id: '3'),
  Pet(
      name: 'Mittens',
      image: './assets/images/fish.png',
      location: 'Khobar 1km',
      favorite: false,
      id: '4'),
  Pet(
      name: 'Buddy',
      image: './assets/images/dog.png',
      location: 'Dammam 4km',
      favorite: false,
      id: '5'),
  Pet(
      name: 'Spike',
      image: './assets/images/bird.png',
      location: 'Riyadh 2km',
      favorite: false,
      id: '6'),
];




