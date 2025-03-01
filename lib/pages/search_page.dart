import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trip_flutter/model/search_model.dart';
import 'package:trip_flutter/util/margin.dart';
import 'package:trip_flutter/util/navigator_util2.dart';

import '../dao/search_dao.dart';
import '../widget/search_bar_widget.dart';
import '../widget/search_bar_widget2.dart';
import '../widget/search_item_widget2.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, this.keyword, this.hit});
  final String? keyword;
  final String? hit;

  @override
  State<SearchPage> createState() => _TravelPageState();
}

class _TravelPageState extends State<SearchPage> {
  SearchModel? searchModel;
  String? keyword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _appBar,
          _listView2,
        ],
      ),
    );
  }

  get getBody {
    return Column(
      children: [
        SearchBarWidget(
          hideLeft: false,
          searchBarType: SearchBarType.normal,
        ),
        SearchBarWidget2(
          hit: "hello",
        )
      ],
    );
  }

  get _appBar {
    double top = MediaQuery.of(context).padding.top;
    return getShadow(
        child: Container(
          height: top + 55,
          decoration: const BoxDecoration(color: Colors.white),
          padding: EdgeInsets.only(top: top),
          child: SearchBarWidget(
            leftClick: () => NavigatorUtil2.pop(context),
            change: _onChange,
            rightClick: () {
              //收起键盘
              FocusScope.of(context).requestFocus(FocusNode());
            },
          ),
        ),
        padding: const EdgeInsets.only(bottom: 5));
  }

  //error  "RenderBox was not laid out: RenderRepaintBoundary#08cc1 relayoutBoundary=up2 NEEDS-PAINT"
  get _listView {
    return ListView.builder(
        itemCount: searchModel?.data?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return _item(index);
        });
  }

  get _listView2 {
    return MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: Expanded(
            child: ListView.builder(
                itemCount: searchModel?.data?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return _item(index);
                })));
  }

  void _onChange(String value) async {
    try {
      var model = await SearchDao.getData(value);
      if (model == null) {
        return;
      }
      if (value == model.keyword) {
        setState(() {
          searchModel = model;
        });
      }
    } catch (ex) {
      print(ex.toString());
    }
  }

  Widget _item(int index) {
    var item = searchModel?.data?[index];
    String result = jsonEncode(item);
    if (null == item) return Container();
    return SearchItemWidget2(searchItem: item, keyword: searchModel!.keyword);
  }
}
