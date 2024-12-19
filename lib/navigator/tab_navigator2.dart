import 'package:flutter/material.dart';
import 'package:trip_flutter/pages/home_page.dart';
import 'package:trip_flutter/pages/my_page.dart';
import 'package:trip_flutter/pages/search_page.dart';
import 'package:trip_flutter/pages/travel_page.dart';

class TabNavigator extends StatefulWidget {
  const TabNavigator({super.key});

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        //physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: const [HomePage(), SearchPage(), TravelPage(), MyPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [_getItem()],
        currentIndex: _currentIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  _getItem() {

  }
}
