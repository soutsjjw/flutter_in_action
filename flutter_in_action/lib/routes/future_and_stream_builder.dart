import 'package:flutter/material.dart';

class FutureAndStreamBuilderRoute extends StatefulWidget {
  @override
  _FutureAndStreamBuilderRouteState createState() =>
      _FutureAndStreamBuilderRouteState();
}

class _FutureAndStreamBuilderRouteState
    extends State<FutureAndStreamBuilderRoute> {
  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: FutureBuilder<String>(
    //     future: mockNetworkData(),
    //     builder: (BuildContext context, AsyncSnapshot snapshot) {
    //       // 請求已結束
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         if (snapshot.hasError) {
    //           // 請求失敗，顯示錯誤
    //           return Text("Error: ${snapshot.error}");
    //         } else {
    //           // 請求成功，顯示數據
    //           return Text("Contents: ${snapshot.data}");
    //         }
    //       } else {
    //         // 請求未結束，顯示loading
    //         return CircularProgressIndicator();
    //       }
    //     },
    //   ),
    // );

    return Center(
      child: StreamBuilder<int>(
        stream: counter(),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('沒有Stream');
            case ConnectionState.waiting:
              return Text('等待數據...');
            case ConnectionState.active:
              return Text('active: ${snapshot.data}');
            case ConnectionState.done:
              return Text('Stream已關閉');
          }
          return null; // unreachable
        },
      ),
    );
  }

  Future<String> mockNetworkData() async {
    return Future.delayed(Duration(seconds: 2), () => "我是從互聯網上獲取的數據");
  }

  Stream<int> counter() {
    return Stream.periodic(Duration(seconds: 1), (i) {
      return i;
    });
  }
}
