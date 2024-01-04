import 'package:flutter/material.dart';

class BottomNavigationEntity{
  late String title;
  late IconData icon;
  late Widget page;

  BottomNavigationEntity({
   required this.title,
   required this.icon,
   required this.page
});
}