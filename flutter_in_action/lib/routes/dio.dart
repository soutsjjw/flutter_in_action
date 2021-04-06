import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class DioWidgetTestRoute extends StatefulWidget {
  @override
  _DioWidgetTestRouteState createState() => _DioWidgetTestRouteState();
}

class _DioWidgetTestRouteState extends State<DioWidgetTestRoute> {
  Dio _dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FutureBuilder(
        future: _dio.get("https://api.github.com/orgs/flutterchina/repos"),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Response response = snapshot.data;
            //發生錯誤
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            //請求成功，通過項目信息構建用於顯示項目名稱的ListView
            return ListView(
              children: response.data.map<Widget>((e) => ListTile(title: Text(e["full_name"]),)).toList(),
            );
          }
          //請求未完成時彈出loading
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

