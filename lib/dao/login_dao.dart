import 'dart:convert';

import 'package:flutter_hi_cache/flutter_hi_cache.dart';
import 'package:http/http.dart' as http;

import '../util/navigator_util.dart';
import 'header_util.dart';

class LoginDao {
  static const boardingPass = "boardingPass";

  static login({required String name, required String pwd}) async {
    Map<String, String> para = {};
    para['userName'] = name;
    para['password'] = pwd;

    var uri = Uri.https('api.geekailab.com', '/uapi/user/login', para);
    final response = await http.post(uri, headers: hiHeaders());

    Utf8Decoder utf8decoder = const Utf8Decoder();
    String bodyString = utf8decoder.convert(response.bodyBytes);
    if (response.statusCode == 200) {
      var result = json.decode(bodyString);
      if (result['code'] == 0 && result['data'] != null) {
        //保存登录令牌
        _saveBoardingPass(result['data']);
      } else {
        throw Exception(bodyString);
      }
    } else {
      throw Exception(bodyString);
    }
  }

  static void logOut() {
    HiCache.getInstance().remove(boardingPass);
    NavigatorUtil.goToLogin();
  }

  static void _saveBoardingPass(String value) {
    HiCache.getInstance().setString(boardingPass, value);
  }

  static getBoardingPass() {
    return HiCache.getInstance().get(boardingPass);
  }
}
