import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_client_app/common/index.dart';
import 'package:github_client_app/models/index.dart';

class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile();     // 保存Profile變更
    super.notifyListeners();  // 通知依賴的Widget更新
  }
}

//#region 用戶狀態

class UserModel extends ProfileChangeNotifier {
  User get user => _profile.user;

  // APP是否登錄(如果有用戶信息，則證明登錄過)
  bool get isLogin => user != null;

  // 用戶信息發生變化，更新用戶信息並通知依賴它的子孫Widgets更新
  set user(User user) {
    if (user?.login != _profile.user?.login) {
      _profile.lastLogin = _profile.user?.login;
      _profile.user = user;
      notifyListeners();
    }
  }
}

//#endregion

//#region APP主題狀態

class ThemeModel extends ProfileChangeNotifier {
  // 獲取當前主題，如果為設置主題，則默認使用藍色主題
  ColorSwatch get theme => Global.themes
      .firstWhere((e) => e.value == _profile.theme, orElse: () => Colors.blue);

  // 主題改變後，通知其依賴項，新主題會立即生效
  set theme(ColorSwatch color) {
    if (color != theme) {
      _profile.theme = color[500].value;
      notifyListeners();
    }
  }
}

//#endregion

//#region APP語言狀態

class LocaleModel extends ProfileChangeNotifier {
  // 獲取當前用戶的APP語言配置Locale類，如果為null，則語言跟隨系統語言
  Locale getLocale() {
    if (_profile.locale == null) return null;
    var t = _profile.locale.split("_");
    return Locale(t[0], t[1]);
  }

  // 獲取當前Locale的字符串表示
  String get locale => _profile.locale;

  // 用戶改變APP語言後，通知依賴項更新，新語言會立即生效
  set locale(String locale) {
    if (locale != _profile.locale) {
      _profile.locale = locale;
      notifyListeners();
    }
  }
}

//#endregion