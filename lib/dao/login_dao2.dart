import 'dart:convert';

import 'package:flutter_hi_cache/flutter_hi_cache.dart';
import 'package:http/http.dart' as http;
import 'package:trip_flutter/dao/header_util.dart';

class LoginDao {
  static const boardingPass = "boardingPass";

  static login({required String name, required String pwd}) async {
    Map<String, String> para = {};
    para["name"] = name;
    para["password"] = pwd;
    Uri uri = Uri.https("", "", para);
    var response = await http.get(uri, headers: hiHeaders());
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = const Utf8Decoder();
      String result = utf8decoder.convert(response.bodyBytes);
      var data = json.decode(result);
      if (data['code'] == 0 && data['data'] != null) {
        setData(data["data"]);
      }
    } else {
      throw Exception("");
    }
  }

  static void setData(String value) {
    HiCache.getInstance().setString(boardingPass, value);
  }

  static String getData() {
    return HiCache.getInstance().get(boardingPass);
  }
}
