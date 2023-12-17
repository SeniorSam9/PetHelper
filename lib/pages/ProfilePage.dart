import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swe463_project/utilities/getImagePlatform.dart';

import '../models/data.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    final petProvider = Provider.of<PetProvider>(context);
    final adoptedPets = petProvider.adoptedPets;
    final reportedPets = petProvider.reportedPets;

    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 240.0,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image(
                  image: AssetImage('assets/images/profileBackground.jpg'),
                  fit: BoxFit.cover,
                ),
                title: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text(
                        'Hello, There!',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  tabs: [
                    Tab(text: 'Adopted'),
                    Tab(text: 'Reported'),
                  ],
                ),
              ),
              pinned: true,
            ),
            SliverFillRemaining(
              child: TabBarView(
                children: [
                  ListView.builder(
                    itemCount: adoptedPets.length,
                    itemBuilder: (BuildContext context, int index) {
                      return buildCard(adoptedPets[index]);
                    },
                  ),
                  // Second tab content
                  ListView.builder(
                    itemCount: reportedPets.length,
                    itemBuilder: (BuildContext context, int index) {
                      return buildCard(reportedPets[index]);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(Pet pet) {
    return Consumer<PetProvider>(
      builder: (context,petProvider, _ ){

      return Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 6, 2, 6),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 90,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 90,
                      height: 80,
                      child: getImagePlatform(pet.image.path, context),

                    )),
              ),
              SizedBox(width: 18),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pet.title,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_city),
                        Text(pet.city,
                            style: Theme.of(context).textTheme.labelSmall),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                flex: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          // size: 60 ,
                            pet.urgency == "Not urgent"
                                ? Icons.signal_cellular_alt_1_bar
                                : pet.urgency == "Urgent"
                                ? Icons.signal_cellular_alt_2_bar
                                : Icons.signal_cellular_alt,
                            color:
                            pet.urgency == "Not urgent" ? Colors.yellow : pet.urgency == "Urgent" ? Colors.orange : Colors.red

                        ),
                        Text(
                          pet.urgency,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    ElevatedButton(
                      onPressed: () async {
                        await petProvider.toggleAdopted(pet);

                      },
                      child: Text(
                        pet.adopted ? "Make available" : "Adopted",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ) ; }
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
