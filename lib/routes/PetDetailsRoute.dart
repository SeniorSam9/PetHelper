import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swe463_project/models/ThemeProvider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/data.dart';
import '../utilities/getImagePlatform.dart';

class PetDetailsRoute extends StatelessWidget {
  final Pet pet;

  PetDetailsRoute({required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${pet.title} Details'),
      ),
      body: Card(
        elevation: 4.0,
        color: Provider.of<ThemeProvider>(context).currentTheme.cardColor,
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
                ],
              ),
            ),
            Center(
              child: Container(
                  height: 200.0,
                  child: getImagePlatform(pet.image.path, context)),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Urgency: ${pet.urgency}',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Type: ${pet.animal_type}',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Location: ',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              Color(0xFF827397))),
                      onPressed: () async {
                        String googleMapsUrl =
                            'https://maps.google.com/?q=${pet.lat},${pet.lng}';
                        if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
                          // Check if the Google Maps app is installed
                          await launchUrl(Uri.parse(googleMapsUrl));
                        } else {
                          // If the Google Maps app is not installed, open the URL in a browser
                          await launchUrl(Uri.parse(googleMapsUrl));
                        }
                      },
                      child: Text('Reach it using Google Maps'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'CONTACT ME: ${pet.contact}',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Description: ${pet.description}.',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
