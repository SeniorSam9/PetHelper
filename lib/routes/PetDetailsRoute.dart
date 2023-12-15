import 'package:flutter/material.dart';

import '../models/data.dart';
import '../utilities/getImagePlatform.dart';

class PetDetailsRoute extends StatelessWidget {
  final Pet pet;

  PetDetailsRoute({required this.pet});

  @override
  Widget build(BuildContext context) {
    // TODO : enhance design NOT IMPORTANT
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Details'),
      ),
      body: Card(
        elevation: 4.0,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.pets, size: 50),
              title: Text('${pet.title}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Priority: "),
                      Icon(
                        pet.urgency == "Not urgent"
                            ? Icons.signal_cellular_alt_1_bar
                            : pet.urgency == "Urgent"
                                ? Icons.signal_cellular_alt_2_bar
                                : Icons.signal_cellular_alt,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () async {
                      // String googleMapsUrl =
                      //     'https://maps.google.com/?q=${pet.lat},${pet.lng}';
                      // if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
                      //   // Check if the Google Maps app is installed
                      //   await launchUrl(Uri.parse(googleMapsUrl));
                      // } else {
                      //   // If the Google Maps app is not installed, open the URL in a browser
                      //   await launchUrl(Uri.parse(googleMapsUrl));
                      // }
                    },
                    child: Text('link to Google Maps'),
                  )
                ],
              ),
            ),
            Center(
              child: Container(
                  height: 200.0,
                  child: getImagePlatform(pet.image.path, context)),
            ),
            // TODO: wrap all below with Column to separate the combined text not important
            // TODO: Done but should be enhanced if there's time
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CONTACT ME: ${pet.contact}',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                SizedBox(height: 16),

                Text(
                  'Description: ${pet.description}.',
                  style: Theme.of(context).textTheme.labelMedium,
                ),

              ],
            )

           ,

          ],
        ),
      ),
    );
  }
}
