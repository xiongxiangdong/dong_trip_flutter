import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trip_flutter/dao/login_dao3.dart';
import 'package:trip_flutter/model/travel_category_model.dart';
import 'package:trip_flutter/util/navigator_util2.dart';

import '../model/travel_tab_model.dart';

class TravelDao {
  static Future<TravelCategoryModel?> getCategory() async {
    var url = Uri.parse('https://api.geekailab.com/uapi/ft/category');
    var response = await http.get(url, headers: LoginDao3.hiHeaders());
    Utf8Decoder utf8decoder = Utf8Decoder();
    String result = utf8decoder.convert(response.bodyBytes);
    if (response.statusCode == 200) {
      var data = json.decode(result);
      return TravelCategoryModel.fromJson(data['data']);
    } else {
      if (response.statusCode == 401) {
        NavigatorUtil2.goLogin();
        return null;
      }
      throw Exception(result);
    }
  }

  static Future<TravelTabModel?> getDetail(
      String code, int page, int pageSize) async {
    Map<String, String> paramsMap = {};
    paramsMap['pageIndex'] = page.toString();
    paramsMap['pageSize'] = pageSize.toString();
    paramsMap['groupChannelCode'] = code;
    var url = Uri.https('api.geekailab.com', '/uapi/ft/travels', paramsMap);

    var response = await http.get(url, headers: LoginDao3.hiHeaders());
    Utf8Decoder utf8decoder = Utf8Decoder();
    String result = utf8decoder.convert(response.bodyBytes);
    if (response.statusCode == 200) {
      var data = json.decode(result);
      return TravelTabModel.fromJson(data['data']);
    } else {
      if (response.statusCode == 401) {
        NavigatorUtil2.goLogin();
        return null;
      }
      throw Exception(result);
    }
  }
}
