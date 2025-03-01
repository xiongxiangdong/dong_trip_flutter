import 'package:flutter/material.dart';
import 'package:trip_flutter/model/search_model.dart';

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

class SearchItemWidget extends StatelessWidget {
  const SearchItemWidget(
      {super.key, required this.searchItem, required this.keyword});

  final SearchItem searchItem;
  final String? keyword;

  get _item => Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 0.3, color: Colors.black))),
        child: Row(
          children: [
            _iconImage,
            Column(
              children: [
                //超长出bug
                SizedBox(
                  width: 200,
                  child: _title,
                ),
                Container(
                  width: 200,
                  margin: const EdgeInsets.only(left: 5),
                  child: _subTitle,
                )
              ],
            )
          ],
        ),
      );

  get _title {
    List<TextSpan> result = [];
    result.addAll(_hight(searchItem.word, keyword ?? ""));
    result.add(TextSpan(
        text: searchItem.districtname ?? '',
        style: const TextStyle(fontSize: 14, color: Colors.grey)));
    return RichText(
      text: TextSpan(children: result),
    );
  }

  get _subTitle => RichText(
          text: TextSpan(
        children: [
          TextSpan(
              text: searchItem.price ?? "",
              style: TextStyle(fontSize: 16, color: Colors.orange)),
          TextSpan(
              text: "${searchItem.star ?? ''}",
              style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ));

  get _iconImage => Container(
        margin: const EdgeInsets.all(1),
        child: Image(
            height: 26,
            width: 26,
            image: AssetImage(_typeImage2(searchItem.type))),
      );

  String _typeImage2(String? type) {
    if (type == null) {
      return "images/type_travelgroup.png";
    }
    String path = "travelgroup";
    for (final val in types) {
      if (type.contains(val)) {
        path = val;
        break;
      }
    }
    return 'images/type_$path.png';
  }

  _hight(String? word, String key) {
    List<TextSpan> list = [];
    if (word == null) {
      return list;
    }
    String wordL = word.toLowerCase(), keyL = key.toLowerCase();
    List<String> arr = word.split(key);
    TextStyle normalStyle = const TextStyle(fontSize: 16, color: Colors.black);
    TextStyle highStyle = const TextStyle(fontSize: 16, color: Colors.orange);
    int preIndex = 0;
    for (int i = 0; i < arr.length; i++) {
      //worwld  [,or,ld]   w  [,]
      //01234
      if (i != 0) {
        preIndex = wordL.indexOf(keyL, preIndex);
        list.add(TextSpan(
          text: word.substring(preIndex, preIndex + key.length),
          style: highStyle,
        ));
      }
      String val = arr[i];
      if (val.isNotEmpty) {
        list.add(TextSpan(
          text: val,
          style: normalStyle,
        ));
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //NavigatorUtil2.
      },
      child: _item,
    );
  }
}
