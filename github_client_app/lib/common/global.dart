import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_client_app/common/index.dart';
import 'package:github_client_app/models/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 提供五套可選主題色
const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];

class Global {
  static SharedPreferences _prefs;
  static Profile profile = Profile();

  // 可選的主題列表
  static List<MaterialColor> get themes => _themes;

  // 是否為release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  // 初始化全局信息，會在APP啟動時執行
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile");
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch(e) {
        print(e);
      }
    }

    // 如果沒有緩存策略，設置默認緩存策略
    CacheConfig _CacheConfig = new CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;
    profile.cache = profile.cache ?? _CacheConfig;

    // 初始化網絡請求相關配置
    Git.init();
  }

  // 持久化Profile信息
  static saveProfile() =>
      _prefs.setString("profile", jsonEncode(profile.toJson()));
}