import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trip_flutter/dao/login_dao3.dart';
import 'package:trip_flutter/model/search_model.dart';
import 'package:trip_flutter/util/navigator_util2.dart';

class SearchDao {
  static Future<SearchModel?> getData(String key) async {
    var uri = Uri.parse("https://api.geekailab.com/uapi/ft/search?q=$key");
    var response = await http.get(uri, headers: LoginDao3.hiHeaders());
    Utf8Decoder utf8decoder = const Utf8Decoder();
    String result = utf8decoder.convert(response.bodyBytes);
    if (response.statusCode == 200) {
      var data = json.decode(result);
      SearchModel model = SearchModel.fromJson(data);
      model.keyword = key;
      return model;
    } else {
      if (response.statusCode == 401) {
        NavigatorUtil2.goLogin();
        return null;
      }
      throw Exception(result);
    }
  }
}
