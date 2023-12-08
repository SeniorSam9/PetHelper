import 'package:flutter/material.dart';
import '../models/data.dart';
import '../routes/CertainPetRoute.dart';

class ListOfPets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 8.0, // Spacing between columns
        mainAxisSpacing: 8.0, // Spacing between rows
      ),
      itemCount: pets.length,
      itemBuilder: (context, index) {
        var pet = pets[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          color: Colors.white,
          elevation: 5,
          child: InkWell(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CertainPetRoute(
                    petName: pet.name,
                  ),
                ),
              );
            },
            child: Stack(
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ),
                    image: DecorationImage(
                      image: AssetImage(pet.image),
                      fit: BoxFit.cover,
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
                        pet.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        pet.location,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: IconButton(
                    icon: pet.favorite
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_border),
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
      },
    );
  }
}
