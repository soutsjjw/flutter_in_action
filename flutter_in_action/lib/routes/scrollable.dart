import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SingleChildScrollViewTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return Scrollbar(
      // 顯示滾動條
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            // 動態創建一個List<Widget>
            children: str
                .split("")
                // 每一個字母都用一個Text顯示，字體為原來的兩倍
                .map((c) => Text(
                      c,
                      textScaleFactor: 2.0,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class ListViewTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> list = <String>[];
    for (var i = 0; i < 150; i++) {
      list.add(i.toString());
    }

    return ListView(
      // 滾動方向
      scrollDirection: Axis.horizontal,
      // 指定子Widget的高度（垂直時）或寬度（水平時）
      itemExtent: 30,
      // 在超出邊界指定值內，緩存item
      cacheExtent: 40,
      shrinkWrap: true,
      padding: EdgeInsets.all(10),
      children: list
          .map((item) => Text(
                item,
                style: TextStyle(fontSize: 16),
              ))
          .toList(),
      controller: ScrollController(
        initialScrollOffset: 120, // 初始滾動位置
        keepScrollOffset: true, // 是否儲存滾動位置
      ),
      addSemanticIndexes: true,
      semanticChildCount: 10,
    );
  }
}

class ListViewBuilderTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> list = <String>[];
    for (var i = 0; i < 150; i++) {
      list.add(i.toString());
    }

    return ListView.builder(
      // 滾動方向
      scrollDirection: Axis.vertical,
      // 指定子Widget的高度（垂直時）或寬度（水平時）
      itemExtent: 30,
      // 在超出邊界指定值內，緩存item
      cacheExtent: 40,
      shrinkWrap: true,
      padding: EdgeInsets.all(10),
      controller: ScrollController(
        initialScrollOffset: 120, // 初始滾動位置
        keepScrollOffset: true, // 是否儲存滾動位置
      ),
      addSemanticIndexes: true,
      semanticChildCount: 10,
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        print(index.toString());
        return Text(list[index]);
      },
    );
  }
}

class ListViewSeparatedTextRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> list = <String>[];
    for (var i = 0; i < 150; i++) {
      list.add(i.toString());
    }

    return ListView.separated(
      scrollDirection: Axis.vertical,
      cacheExtent: 40,
      shrinkWrap: true,
      padding: EdgeInsets.all(10),
      controller:
          ScrollController(initialScrollOffset: 120, keepScrollOffset: true),
      addSemanticIndexes: true,
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        print(index.toString());
        return Text(list[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Colors.blue,
        );
      },
    );
  }
}

class GridViewFixedCrossTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 橫軸三個子Widget
          childAspectRatio: 1.0 // 寬高比為1時，子widget
          ),
      children: <Widget>[
        Icon(Icons.ac_unit),
        Icon(Icons.airport_shuttle),
        Icon(Icons.all_inclusive),
        Icon(Icons.beach_access),
        Icon(Icons.cake),
        Icon(Icons.free_breakfast),
      ],
    );
  }
}

class GridViewMaxCrossTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 120, childAspectRatio: 2.0 // 寬高比為2
          ),
      children: <Widget>[
        Icon(Icons.ac_unit),
        Icon(Icons.airport_shuttle),
        Icon(Icons.all_inclusive),
        Icon(Icons.beach_access),
        Icon(Icons.cake),
        Icon(Icons.free_breakfast),
      ],
    );
  }
}

class InfiniteGridView extends StatefulWidget {
  @override
  _InfiniteGridViewState createState() => _InfiniteGridViewState();
}

class _InfiniteGridViewState extends State<InfiniteGridView> {
  List<IconData> _icons = []; // 保存Icon資料

  @override
  void initState() {
    // 初始化數據
    _retrieveIcons();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 每行三列
          childAspectRatio: 1.0, // 顯示區域寬高相等
        ),
        itemCount: _icons.length,
        itemBuilder: (context, index) {
          // 如果顯示到最後一個並且Icon總數小於200時，繼續獲取數據
          if (index == _icons.length - 1 && _icons.length < 200) {
            _retrieveIcons();
          }
          return Icon(_icons[index]);
        });
  }

  // 模擬異步獲取數據
  void _retrieveIcons() {
    Future.delayed(Duration(milliseconds: 200)).then((e) {
      setState(() {
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.cake,
          Icons.free_breakfast
        ]);
      });
    });
  }
}

class FlutterStaggeredGridViewTestRoute extends StatelessWidget {
  List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
    const StaggeredTile.count(2, 2),
    const StaggeredTile.count(2, 1),
    const StaggeredTile.count(1, 2),
    const StaggeredTile.count(1, 1),
    const StaggeredTile.count(2, 2),
    const StaggeredTile.count(1, 2),
    const StaggeredTile.count(1, 1),
    const StaggeredTile.count(3, 1),
    const StaggeredTile.count(1, 1),
    const StaggeredTile.count(4, 1),
  ];

  List<Widget> _tiles = const <Widget>[
    const _FlutterStaggeredGridViewTestRouteTile(Colors.green, Icons.widgets),
    const _FlutterStaggeredGridViewTestRouteTile(Colors.lightBlue, Icons.wifi),
    const _FlutterStaggeredGridViewTestRouteTile(
        Colors.amber, Icons.panorama_wide_angle),
    const _FlutterStaggeredGridViewTestRouteTile(Colors.brown, Icons.map),
    const _FlutterStaggeredGridViewTestRouteTile(Colors.deepOrange, Icons.send),
    const _FlutterStaggeredGridViewTestRouteTile(
        Colors.indigo, Icons.airline_seat_flat),
    const _FlutterStaggeredGridViewTestRouteTile(Colors.red, Icons.bluetooth),
    const _FlutterStaggeredGridViewTestRouteTile(
        Colors.pink, Icons.battery_alert),
    const _FlutterStaggeredGridViewTestRouteTile(
        Colors.purple, Icons.desktop_windows),
    const _FlutterStaggeredGridViewTestRouteTile(Colors.blue, Icons.radio),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('example 01'),
        ),
        body: new Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: new StaggeredGridView.count(
              crossAxisCount: 4,
              staggeredTiles: _staggeredTiles,
              children: _tiles,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              padding: const EdgeInsets.all(4.0),
            )));
  }
}

class _FlutterStaggeredGridViewTestRouteTile extends StatelessWidget {
  const _FlutterStaggeredGridViewTestRouteTile(
      this.backgroundColor, this.iconData);

  final Color backgroundColor;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: backgroundColor,
      child: new InkWell(
        onTap: () {},
        child: new Center(
          child: new Padding(
            padding: const EdgeInsets.all(4.0),
            child: new Icon(
              iconData,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomScrollViewTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 因為本路由沒有使用Scaffold，為了讓子級Widget(如Text)使用
    // Material Design 默認的樣式風格,我們使用Material作為本路由的根。
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("Demo"),
              background: Image.asset(
                "./images/under_the_wave_off_kanagawa.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: new SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  // 創建子widget
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: Text("grid item $index"),
                  );
                },
                childCount: 20,
              ),
            ),
          ),
          SliverFixedExtentList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                //創建列表項
                return new Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * (index % 9)],
                  child: new Text('list item $index'),
                );
              },
                      //50個列表項
                      childCount: 50),
              itemExtent: 50.0)
        ],
      ),
    );
  }
}

class ScrollControllerTestRoute extends StatefulWidget {
  @override
  _ScrollControllerTestRouteState createState() =>
      _ScrollControllerTestRouteState();
}

class _ScrollControllerTestRouteState extends State<ScrollControllerTestRoute> {
  ScrollController _controller = ScrollController();
  bool showToTopBtn = false; //是否顯示「返回到頂部」按鈕

  @override
  void initState() {
    super.initState();
    // 監聽滾動事件，打印滾動位置
    _controller.addListener(() {
      print(_controller.offset); //打印滾動位置
      if (_controller.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_controller.offset >= 1000 && !showToTopBtn) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("滾動控制"),
      ),
      body: Scrollbar(
        child: ListView.builder(
            itemCount: 100,
            itemExtent: 50.0, //列表項高度固定時，顯式指定高度是一個好習慣(性能消耗小)
            controller: _controller,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("$index"),
              );
            }),
      ),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                _controller.animateTo(.0,
                    duration: Duration(milliseconds: 200), curve: Curves.ease);
              }),
    );
  }
}

class ScrollNotificationTestRoute extends StatefulWidget {
  @override
  _ScrollNotificationTestRouteState createState() =>
      _ScrollNotificationTestRouteState();
}

class _ScrollNotificationTestRouteState
    extends State<ScrollNotificationTestRoute> {
  String _progress = "0%"; //保存進度百分比

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: NotificationListener<ScrollNotification>(
        // ignore: missing_return
        onNotification: (ScrollNotification notification) {
          double progress = notification.metrics.pixels /
              notification.metrics.maxScrollExtent;
          setState(() {
            _progress = "${(progress * 100).toInt()}%";
          });
          print("BottomEdge: ${notification.metrics.extentAfter == 0}");
          //return true; //放開此行注釋後，進度條將失效
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ListView.builder(
                itemCount: 100,
                itemExtent: 50.0,
                itemBuilder: (context, index) {
                  return ListTile(title: Text("$index"));
                }),
            //顯示進度百分比
            CircleAvatar(
              radius: 30.0,
              child: Text(_progress),
              backgroundColor: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}
