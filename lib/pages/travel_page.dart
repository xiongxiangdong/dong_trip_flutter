import 'package:flutter/material.dart';
import 'package:trip_flutter/dao/travel_dao.dart';
import 'package:trip_flutter/model/travel_category_model.dart';
import 'package:trip_flutter/pages/travel_tab_page.dart';
import 'package:underline_indicator/underline_indicator.dart';

class TravelPage extends StatefulWidget {
  const TravelPage({super.key});

  @override
  State<TravelPage> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin {
  List<TravelTab> tabs = [];
  TravelCategoryModel? travelCategoryModel;
  String text = "";
  late TabController controller;

  get _tabBar => TabBar(
        controller: controller,
        isScrollable: true,
        labelColor: Colors.black,
        //设置tab左对齐
        tabAlignment: TabAlignment.start,
        //下划线宽度
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: const UnderlineIndicator(
          borderSide: BorderSide(width: 3, color: Colors.blue),
          insets: EdgeInsets.only(bottom: 5),
        ),
        tabs: tabs.map((item) {
          return Tab(
            text: item.labelName,
          );
        }).toList(),
      );

  get _tabItem {
    return TabBarView(
      controller: controller,
      children: tabs.map((item) {
        return TravelTabPage(
          code: item.groupChannelCode,
        );
      }).toList(),
    );
  }

  @override
  void initState() {
    super.initState();
    //travelCategoryModel = TravelDao.getCategory();
    controller = TabController(length: 0, vsync: this);
    TravelDao.getCategory().then((TravelCategoryModel? model) {
      controller = TabController(length: model?.tabs.length ?? 0, vsync: this);
      setState(() {
        tabs = model?.tabs ?? [];
        travelCategoryModel = model;
      });
    });
  }

  initData() async {
    TravelCategoryModel? model = await TravelDao.getCategory();
    setState(() {
      travelCategoryModel = model;
    });
  }

  @override
  Widget build(BuildContext context) {
    double top = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: top),
            child: _tabBar,
          ),
          Expanded(child: _tabItem)
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
