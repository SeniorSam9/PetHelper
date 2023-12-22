import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:swe463_project/features/common/utilities/getImagePlatform.dart';

import 'package:url_launcher/url_launcher.dart';

import 'utilities/ThemeProvider.dart';
import 'data.dart';

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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 4, 1, 2),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  trailing: Icon(Icons.pets, size: 50),
                  title: Text('${pet.title}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [],
                  ),
                ),
                Center(
                  child: Container(
                      height: 200.0,
                      child: getImagePlatform(pet.image.path, context,
                          fit: BoxFit.cover)),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Pet type: ${pet.animal_type}',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'City: ${pet.city}',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Priority: ",
                            style: Theme.of(context).textTheme.labelMedium),
                        Icon(
                            size: 45,
                            // size: 60 ,
                            pet.urgency == "Not urgent"
                                ? Icons.signal_cellular_alt_1_bar
                                : pet.urgency == "Urgent"
                                    ? Icons.signal_cellular_alt_2_bar
                                    : Icons.signal_cellular_alt,
                            color: pet.urgency == "Not urgent"
                                ? Colors.yellow
                                : pet.urgency == "Urgent"
                                    ? Colors.orange
                                    : Colors.red),
                        Text(pet.urgency,
                            style: Theme.of(context).textTheme.labelMedium),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Description: ${pet.description}.',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 4.0,
                            color: Theme.of(context).primaryColor,
                            child: InkWell(
                              onTap: () async {
                                String googleMapsUrl =
                                    'https://maps.google.com/?q=${pet.lat},${pet.lng}';
                                if (await canLaunchUrl(
                                    Uri.parse(googleMapsUrl))) {
                                  await launchUrl(Uri.parse(googleMapsUrl));
                                } else {
                                  await launchUrl(Uri.parse(googleMapsUrl));
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      "Pet's Location",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(width: 12),
                        Expanded(
                          child: Card(
                            elevation: 4.0,
                            color: Theme.of(context).primaryColor,
                            child: InkWell(
                              onTap: () async {
                                await Clipboard.setData(
                                    ClipboardData(text: pet.contact));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text("Contact copied to clipboard"),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.contact_phone,
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      "Contact Me",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
