import 'package:flutter/material.dart';
import 'package:trip_flutter/pages/home_page3.dart';

import '../pages/my_page.dart';
import '../pages/search_page.dart';
import '../pages/travel_page.dart';
import '../util/navigator_util2.dart';

class TabNavigator2 extends StatefulWidget {
  const TabNavigator2({super.key});

  @override
  State<TabNavigator2> createState() => _TabNavigator2State();
}

class _TabNavigator2State extends State<TabNavigator2> {
  final PageController _controller = PageController(
    initialPage: 0,
  );

  int _currentIndex = 0;
  final defaultColor = Colors.grey;
  final selectColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    NavigatorUtil2.setContext(context);
    return Scaffold(
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: const [HomePage3(), TravelPage(), SearchPage(), MyPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: selectColor,
        items: [
          getItem(Icons.home, "Home", 0),
          getItem(Icons.search, "Home", 1),
          getItem(Icons.camera_alt, "Home", 2),
          getItem(Icons.account_circle, "Home", 3),
        ],
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  getItem(IconData icon, String title, int index) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: defaultColor,
      ),
      activeIcon: Icon(
        icon,
        color: selectColor,
      ),
      label: title,
    );
  }
}
