import 'package:flutter/material.dart';
import 'package:trip_flutter/pages/search_page.dart';
import 'package:trip_flutter/widget/banner_widget.dart';
import 'package:trip_flutter/widget/search_bar_widget.dart';
import 'package:trip_flutter/widget/sub_nav_widget.dart';

import '../dao/home_dao.dart';
import '../dao/login_dao3.dart';
import '../model/home_model.dart';
import '../util/margin.dart';
import '../util/navigator_util2.dart';
import '../widget/grid_nav_widget.dart';
import '../widget/loading_container_widget.dart';
import '../widget/local_nav_widget.dart';
import '../widget/sales_box_widget.dart';

class HomePage3 extends StatefulWidget {
  const HomePage3({super.key});

  @override
  State<HomePage3> createState() => _HomePage3State();
}

class _HomePage3State extends State<HomePage3> {
  final _getLogin = const ElevatedButton(
      onPressed: NavigatorUtil2.goLogin, child: Text("LoginOut"));
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  final String searchDefaultText = '网红打卡';

  get _logoutBtn => TextButton(
      onPressed: () {
        LoginDao3.logout();
      },
      child: const Text("LoginOut"));

  double op = 0;

  get _appBar2 {
    //获取刘海屏
    double top = MediaQuery.of(context).padding.top;
    return Column(
      children: [
        getShadow(
          padding: EdgeInsets.only(top: top),
          child: Container(
            height: 60 + top,
            padding: EdgeInsets.only(top: top),
            decoration: BoxDecoration(
                color: Color.fromARGB((op * 255).toInt(), 255, 255, 255)),
            child: SearchBarWidget(
              searchBarType:
                  op > 0.2 ? SearchBarType.homeLight : SearchBarType.home,
              inputClick: _jumpSearch,
              defaultText: searchDefaultText,
              rightClick: () {
                LoginDao3.logout();
              },
            ),
          ),
        ),
        Container(
          height: op > 0.2 ? 0.5 : 0,
          decoration: const BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]),
        ),
      ],
    );
  }

  get _appBar => Opacity(
        opacity: op,
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          height: 80,
          decoration: const BoxDecoration(color: Colors.white),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text("Home"),
            ),
          ),
        ),
      );

  get _listView => ListView(
        children: [
          BannerWidget(bannerList: bannerList),
          LocalNavWidget(list: localNavList),
          if (gridNavModel != null)
            GridNavWidget(
              gridNav: gridNavModel!,
            ),
          SubNavWidget(
            suNavList: subNavList,
          ),
          if (salesBoxModel != null)
            SalesBoxWidget(
              salesBox: salesBoxModel!,
            ),
        ],
      );

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _handRefresh();
  }

  List<CommonModel> localNavList = [];
  List<CommonModel> bannerList = [];
  List<CommonModel> subNavList = [];
  GridNav? gridNavModel;
  SalesBox? salesBoxModel;

  var bodyS = "";
  Future<void> _handRefresh() async {
    try {
      HomeModel? homeModel = await HomeDao.getData2();
      if (homeModel == null) {
        setState(() {
          _loadding = false;
        });
        return;
      }
      setState(() {
        localNavList = homeModel?.localNavList ?? [];
        bannerList = homeModel?.bannerList ?? [];
        subNavList = homeModel?.subNavList ?? [];
        gridNavModel = homeModel?.gridNav;
        salesBoxModel = homeModel?.salesBox;
        _loadding = false;
        print("localNavList:${gridNavModel?.hotel?.startColor?.toString()}");
      });
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        _loadding = false;
      });
    }
  }

  bool _loadding = true;

  @override
  Widget build(BuildContext context) {
    //NavigatorUtil2.setContext(context);
    /*return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: Stack(
        children: [_contentView, _appBar2],
      ));*/
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: LoadingContainerWidget(
        isLoading: _loadding,
        child: Stack(
          children: [_contentView, _appBar2],
        ),
      ),
    );
  }

  _getFirst() {
    /*return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [_logoutBtn],
      ),
      body: Column(
        children: [BannerWidget(bannerList: imgList)],
      ),
    );*/
  }

  static const distance = 100;

  get _contentView => MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: NotificationListener(
          onNotification: (noti) {
            if (noti is ScrollUpdateNotification && noti.depth == 0) {
              _scroll(noti.metrics.pixels);
            }
            return false;
          },
          child: RefreshIndicator(
              color: Colors.blue, child: _listView, onRefresh: _handRefresh)));

  void _scroll(double pixels) {
    print("object:$pixels");
    var result = pixels / distance;
    if (result < 0) {
      result = 0;
    }
    if (result > 1) {
      result = 1;
    }
    print("op:$result");
    setState(() {
      op = result;
    });
  }

  void _jumpSearch() {
    NavigatorUtil2.push(context, const SearchPage());
  }
}
