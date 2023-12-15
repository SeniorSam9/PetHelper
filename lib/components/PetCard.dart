import 'package:flutter/material.dart';
import 'package:swe463_project/models/data.dart';
import '../routes/PetDetailsRoute.dart';
import '../utilities/getImagePlatform.dart';

class PetCard extends StatelessWidget {
  final Pet pet;

  const PetCard({required this.pet, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      elevation: 5,
      child: InkWell(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PetDetailsRoute(
                pet: pet,
              ),
            ),
          );
        },
        child: Stack(
          children: [
            Container(
              child: getImagePlatform(pet.image.path, context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pet.title,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(pet.city, style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: IconButton(
                icon:
                    5 > 5 ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
                color: Colors.red,
                onPressed: () {
                  // Handle heart button press
                  // You can implement your logic here, such as updating favorites, etc.
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
