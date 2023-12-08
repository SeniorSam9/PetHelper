import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/data.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Pet> adoptedPets = [];
  List<Pet> reportedPets = [];
  @override
   void initState(){
      adoptedPets = pets.where((pet) => pet.adopted).toList() ;
      reportedPets = pets.where((pet) => !pet.adopted).toList() ;
      super.initState() ; }

  @override
  Widget build(BuildContext context) {
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
                child: Image(
                  width: 90,
                  height: 80,
                  fit: BoxFit.cover,
                  image: AssetImage(pet.image),
                ),
              ),
            ),

            SizedBox(width: 18),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pet.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_city),
                      Text(pet.location),
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
                        CupertinoIcons.exclamationmark,
                      ),
                      Text(pet.urgency.stringValue),
                    ],
                  ),
                  SizedBox(height: 6),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      pet.adopted ? "Adopted" : "Reported",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
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
