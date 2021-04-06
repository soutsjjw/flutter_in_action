import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:github_client_app/common/index.dart';
import 'package:github_client_app/models/index.dart';
import 'package:path_provider/path_provider.dart' as pp;

class Git {
  Git([this.context]) {
    _options = Options(extra: {"context": context});
  }

  BuildContext context;
  Options _options;

  static CacheStore cacheStore;
  static Dio dio = Dio(BaseOptions(
    baseUrl: "https://api.github.com",
    headers: {
      HttpHeaders.acceptHeader: "application/vnd.github.squirrel-girl-preview,"
          "application/vnd.github.symmetra-preview+json",
    },
  ));

  static void init() {
    pp.getApplicationDocumentsDirectory().then((dir) {
      cacheStore = DbCacheStore(databasePath: dir.path, logStatements: true);
      // cacheStore = FileCacheStore(dir.path);

      // 添加緩存插件
      dio.interceptors.add(
        DioCacheInterceptor(options: CacheOptions(store: cacheStore)),
      );
    });

    // 設置用戶token（可能為null，代表未登錄）
    dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile.token;

    // 在調式模式下需要抓包調試，所以我們使用代理，並禁用HTTPS證書校驗
    if (!Global.isRelease) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          return "PROXY 10.95.249.53:8888";
        };
        // 代理工具會提供一個抓包的自簽名證書，會通不過證書校驗，所以我們禁用證書校驗
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  // 登錄接口，登錄成功後返回用戶信息
  Future<User> login(String login, String pwd) async {
    String basic = "Basic " + base64.encode(utf8.encode("$login:$pwd"));

    _options.headers = {HttpHeaders.authorizationHeader: basic};
    _options.extra = {"noCache": true}; //本接口禁用緩存

    var r = await dio.get(
      "/users/$login",
      options: _options,
    );

    // 登錄成功後更新公共頭（authorization），此後的所有請求都會帶上用戶身份信息
    dio.options.headers[HttpHeaders.authorizationHeader] = basic;
    // 清空所有緩存
    await _cleanStore();
    // 更新profile中的token信息
    Global.profile.token = basic;
    return User.fromJson(r.data);
  }

  // 獲取用戶項目列表
  Future<List<Repo>> getRepos(
      {Map<String, dynamic> queryParameters, refresh = false}) async {
    if (refresh) {
      // 列表下拉刷新，需要刪除緩存（攔截器中會讀取這些信息）
      _options.extra.addAll({"refresh": true, "list": true});
    }
    var r = await dio.get<List>(
      "user/repos",
      queryParameters: queryParameters,
      options: _options,
    );
    return r.data.map((e) => Repo.fromJson(e)).toList();
  }

  Future _cleanStore() async {
    await cacheStore.clean();
  }
}
