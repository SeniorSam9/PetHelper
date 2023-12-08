import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/data.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int itemCount = 10; 

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
                    itemCount: pets.length,
                    itemBuilder: (BuildContext context, int index) {
                      return buildCard(index);
                    },
                  ),
                  // Second tab content
                  ListView.builder(
                    itemCount: pets.length,
                    itemBuilder: (BuildContext context, int index) {
                      return buildCard(index);
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

  Widget buildCard(int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(2, 6, 2, 6),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: 120,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: AssetImage(pets[index].image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(width: 4),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pets[index].name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_city),
                      Text(pets[index].location),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.exclamationmark,
                      ),
                      Text(pets[index].urgency.stringValue)

                    ],
                  ),
                  SizedBox(height: 6),
                  Container(
                    width: 80,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        pets[index].adopted.toString() ,

                      ),

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
