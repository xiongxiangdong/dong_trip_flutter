import 'package:flutter/material.dart';

import '../model/home_model.dart';

class SubNavWidget2 extends StatelessWidget {
  const SubNavWidget2({super.key, required this.subNavList});

  final List<CommonModel> subNavList;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(7, 0, 7, 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.amber),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    List<Widget> list = [];
    for (var item in subNavList) {
      list.add(_item(context, item));
    }
    int middle = (subNavList.length / 2 + 0.5).toInt();
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: list.sublist(0, middle),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: list.sublist(middle, subNavList.length),
        ),
      ),
    ]);
  }

  Widget _item(BuildContext context, CommonModel item) {
    return Expanded(
        child: GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Image.network(
            item.icon!,
            width: 18,
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Text(
              item.title!,
              style: const TextStyle(color: Colors.black, fontSize: 12),
            ),
          )
        ],
      ),
    ));
  }
}
