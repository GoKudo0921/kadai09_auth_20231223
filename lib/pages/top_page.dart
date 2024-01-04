import 'package:flutter/material.dart';
import 'package:kadai09_kudogo/model/bottom_navigation.dart';
import 'package:kadai09_kudogo/pages/point_list_page.dart';

import 'watch_video_page.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key, required this.title});

  final String title;

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  List<BottomNavigationEntity> navigationList = [
    BottomNavigationEntity(title: 'ポイント獲得', icon: Icons.control_point_duplicate, page: const PointListPage()),
    BottomNavigationEntity(title: 'ブースト', icon: Icons.trending_up, page: const WatchVideoPage())
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: navigationList[selectedIndex].page,
      bottomNavigationBar: BottomNavigationBar(currentIndex: selectedIndex,
      onTap: (int newIndex){
        setState(() {
          selectedIndex = newIndex;
        });
      },
        items: navigationList.map((item) => BottomNavigationBarItem(
            icon:Icon(item.icon),
            label:item.title,
        )).toList(),
      ),
    );
  }
}
