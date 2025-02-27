import 'package:flutter/material.dart';
import 'package:trip_flutter/model/home_model.dart';

class SubNavWidget extends StatelessWidget {
  final List<CommonModel>? suNavList;

  const SubNavWidget({super.key, this.suNavList});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(7, 0, 7, 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.red),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    if (suNavList == null) {
      return null;
    }
    List<Widget> items = [];
    for (var item in suNavList!) {
      items.add(_item(context, item));
    }
    int top = (suNavList!.length / 2 + 0.5).toInt();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, top),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(top, suNavList!.length),
          ),
        )
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel item) {
    return Expanded(
        child: GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Image.network(
            item.icon!,
            height: 18,
            width: 18,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Text(
              item.title!,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    ));
  }
}
