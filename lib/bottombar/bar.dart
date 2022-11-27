import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

List<SalomonBottomBarItem> bottomBarItems() {
  return [
      SalomonBottomBarItem(
        icon: const Icon(
          Icons.area_chart_outlined,
        ),
        title: const Text('Main'),
        selectedColor: Colors.green,
        unselectedColor: Colors.grey,
      ),
      SalomonBottomBarItem(
        icon: const Icon(
          Icons.monetization_on_outlined,
        ),
        title: const Text('Portfolio'),
        selectedColor: Colors.green,
        unselectedColor: Colors.grey,
      ),
      SalomonBottomBarItem(
        icon: const Icon(
          Icons.more_horiz,
        ),
        title: const Text('More'),
        selectedColor: Colors.green,
        unselectedColor: Colors.grey,
      ),
    ];
}