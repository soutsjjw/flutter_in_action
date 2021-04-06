import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class HttpTestRoute extends StatefulWidget {
  @override
  _HttpTestRouteState createState() => _HttpTestRouteState();
}

class _HttpTestRouteState extends State<HttpTestRoute> {
  bool _loading = false;
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              child: Text("獲取百度首頁"),
              onPressed: _loading ? null : () async {
                setState(() {
                  _loading = true;
                  _text = "正在請求...";
                });
                try {
                  //創建一個HttpClient
                  HttpClient httpClient = HttpClient();
                  //打開Http連接
                  HttpClientRequest request = await httpClient.getUrl(Uri.parse("https://www.baidu.com"));
                  //使用iPhone的UA
                  request.headers.add("user-agent", "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1");
                  //等待連接服務器（會將請求信息發送給服務器）
                  HttpClientResponse response = await request.close();
                  //讀取響應內容
                  _text = await response.transform(utf8.decoder).join();
                  //輸出響應頭
                  print(response.headers);

                  //關閉client後，通過該client發起的所有請求都會中止。
                  httpClient.close();
                } catch(e) {
                  _text = "請求失敗：$e";
                } finally {
                  setState(() {
                    _loading = false;
                  });
                }
              }),
            Container(
              width: MediaQuery.of(context).size.width - 50.0,
              child: Text(_text.replaceAll(RegExp(r"\s"), "")),
            ),
          ],
        ),
      ),
    );
  }
}
