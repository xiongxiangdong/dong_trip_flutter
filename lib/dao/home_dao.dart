import 'dart:convert';

import 'package:flutter/cupertino.dart';
import "package:http/http.dart" as http;
import 'package:trip_flutter/model/home_model.dart';
import 'package:trip_flutter/util/navigator_util.dart';

import 'login_dao3.dart';

class HomeDao {
  static Future<String?> getData() async {
    var url = Uri.parse('https://api.geekailab.com/uapi/ft/home');
    var response = await http.get(url, headers: LoginDao3.hiHeaders());
    Utf8Decoder utf8decoder = const Utf8Decoder();
    String result = utf8decoder.convert(response.bodyBytes);
    debugPrint(result);
    if (response.statusCode == 200) {
      return result;
    } else if (response.statusCode == 401) {
      NavigatorUtil.goToLogin();
      return null;
    } else {
      throw Exception(result);
    }
  }

  static Future<HomeModel?> getData2() async {
    var url = Uri.parse('https://api.geekailab.com/uapi/ft/home');
    var response = await http.get(url, headers: LoginDao3.hiHeaders());
    Utf8Decoder utf8decoder = const Utf8Decoder();
    String result = utf8decoder.convert(response.bodyBytes);
    if (response.statusCode == 200) {
      var data = json.decode(result);
      return HomeModel.fromJson(data['data']);
    } else {
      if (response.statusCode == 401) {
        NavigatorUtil.goToLogin();
        return null;
      }
      throw Exception(result);
    }
  }
}
