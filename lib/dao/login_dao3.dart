import 'dart:convert';

import 'package:flutter_hi_cache/flutter_hi_cache.dart';
import 'package:http/http.dart' as http;

import '../util/navigator_util2.dart';

class LoginDao3 {
  static const boardingPass = "boardingPass";

  static login({required String user, required String pwd}) async {
    //var para = {"userName": user, "password": pwd};
    //var uri = Uri.https('api.geekailab.com', '/uapi/user/login', para);

    Map<String, String> para = {};
    para['userName'] = user;
    para['password'] = pwd;
    var uri = Uri.https('api.geekailab.com', '/uapi/user/login', para);
    final response = await http.post(uri, headers: hiHeaders());
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = const Utf8Decoder();
      var body = utf8decoder.convert(response.bodyBytes);
      var result = jsonDecode(body);
      if (result['code'] == 0 && result['data'] != null) {
        //保存登录令牌
        setBorder(result['data']);
      } else {
        throw Exception(result);
      }
    } else {
      throw Exception(response.body);
    }
  }

  static getBorder() {
    var cache = HiCache.getInstance();
    return cache.get(boardingPass);
  }

  static setBorder(String? border) {
    var cache = HiCache.getInstance();
    cache.setString(boardingPass, border ?? "");
  }

  static logout() {
    var cache = HiCache.getInstance();
    cache.remove(boardingPass);
    NavigatorUtil2.goLogin();
  }

  static hiHeaders() {
    Map<String, String> header = {
      "auth-token": "ZmEtMjAyMS0wNC0xMaiAyMToyddMjoyMC1mYQ==ft",
      "course-flag": 'ft',
      "boarding-pass": getBorder() ?? ""
    };
    return header;
  }
}
