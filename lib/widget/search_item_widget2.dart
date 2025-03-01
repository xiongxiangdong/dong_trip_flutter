import 'package:flutter/material.dart';

import '../model/search_model.dart';

const types = [
  'channelgroup',
  'channelgs',
  'channelplane',
  'channeltrain',
  'cruise',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'sight',
  'ticket',
  'travelgroup'
];

class SearchItemWidget2 extends StatelessWidget {
  const SearchItemWidget2({super.key, required this.searchItem, this.keyword});

  final SearchItem searchItem;
  final String? keyword;

  get _item => Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey)),
        ),
        child: Row(
          children: [
            _icon,
            _content,
          ],
        ),
      );

  get _icon => Container(
        margin: const EdgeInsets.all(1),
        child: Image(
            height: 26, width: 26, image: AssetImage(getPath(searchItem.type))),
      );

  get _content => Container(
        child: Column(
          children: [
            SizedBox(
              width: 200,
              child: _title,
            ),
            SizedBox(
              width: 200,
              child: _subTitle,
            ),
          ],
        ),
      );

  get _title {
    return Text(searchItem.word ?? "");
  }

  get _subTitle {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
            text: searchItem.price ?? "",
            style: TextStyle(fontSize: 14, color: Colors.black)),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: _item,
    );
  }

  String getPath(String? type) {
    String url = "images/type_travelgroup.png";
    if (type == null) {
      return url;
    }
    String path = "travelgroup";
    for (var item in types) {
      if (item.contains(type)) {
        path = item;
      }
    }
    return "images/type_$path.png";
  }
}
