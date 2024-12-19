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
  final PageController _controller = PageController(initialPage: 0);
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        //禁止滚动
        physics: const NeverScrollableScrollPhysics(),
        children: const [HomePage(), SearchPage(), TravelPage(), MyPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          _bottoms("Home", Icons.home, 0),
          _bottoms("Search", Icons.search, 1),
          _bottoms("Travel", Icons.camera_alt, 2),
          _bottoms("Mine", Icons.account_circle, 3),
        ],
        currentIndex: _index,
        onTap: (index) {
          _index = index;
          _controller.jumpToPage(index);
        },
        type: BottomNavigationBarType.fixed,
      ),
      // /v1/ticker step=60 symbol=btc_usdt
    );
  } //https://api.hotcoinfin.com/v1/ticker?step=60&symbol=btc_usdt

  final _dcl = Colors.grey;
  final _activeCol = Colors.blue;
  _bottoms(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: _dcl,
      ),
      activeIcon: Icon(
        icon,
        color: _activeCol,
      ),
      label: title,
    );
  }
}
