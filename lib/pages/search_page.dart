import 'dart:convert';

import 'package:flutter/material.dart';

import '../dao/search_dao.dart';
import '../widget/search_bar_widget.dart';
import '../widget/search_bar_widget2.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _TravelPageState();
}

class _TravelPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Searchsss"),
      ),
      body: Column(
        children: [
          SearchBarWidget(
            hideLeft: false,
            searchBarType: SearchBarType.normal,
            change: _onChange,
          ),
          SearchBarWidget2(
            hit: "hello",
          )
        ],
      ),
    );
  }

  void _onChange(String value) async {
    var model = await SearchDao.getData(value);
    print(jsonEncode(model));
  }
}
