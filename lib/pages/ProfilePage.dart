import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                    itemCount: itemCount,
                    itemBuilder: (BuildContext context, int index) {
                      return buildCard(index);
                    },
                  ),
                  // Second tab content
                  ListView.builder(
                    itemCount: itemCount,
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
        padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image(
                image: AssetImage('assets/images/injured bird.png'),
                width: 120,
                height: 120,
              ),
            ),
            SizedBox(width: 6),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Announcement title $index',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_city),
                      Text("Medinah"),
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
                      Text("very urgent")

                    ],
                  ),
                  SizedBox(height: 6),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Adopted",
                      style: TextStyle(
                        color: Colors.white, // Fixed color
                      ),

                    ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple[100]
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
