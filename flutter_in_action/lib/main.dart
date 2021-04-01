import 'package:flutter/material.dart';
import 'package:flutter_in_action/routes/index.dart';
import 'package:flutter_in_action/widgets/index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: "/",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (context) => MyHomePage(title: 'Flutter Demo Home Page'),
        "new_page": (context) => NewRoute(),
        "echo_route": (context) => EchoRoute(),
        "tip2": (context) {
          return TipRoute(text: ModalRoute.of(context).settings.arguments);
        },
      },
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) {
          String routeName = settings.name;
          // 如果訪問的路由頁需要登入，但當前未登入，則直接回傳登入路由，
          // 引導用戶登入；其它情況則正常打開路由。
        });
      },
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _openPage(BuildContext context, PageInfo page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      if (!page.withScaffold) {
        return page.builder(context);
      }
      return PageScaffold(
        title: page.title,
        body: page.builder(context),
        padding: page.padding,
      );
    }));
  }

  List<Widget> _generateItem(BuildContext context, List<PageInfo> children) {
    return children.map<Widget>((page) {
      return ListTile(
        title: Text(page.title),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () => _openPage(context, page),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          ExpansionTile(
            title: Text("第一个Flutter應用"),
            children: _generateItem(context, [
              PageInfo("路由傳值", (ctx) => RouterTestRoute()),
            ]),
          ),
          ExpansionTile(
            title: Text("基礎組件"),
            children: _generateItem(context, [
              PageInfo("Context測試", (ctx) => ContextRoute(), withScaffold: false),
              PageInfo("State生命週期", (ctx) => StateLifeCycle(), withScaffold: false),
              PageInfo("Widget樹獲取State對象", (ctx) => RetrieveStateRoute(), withScaffold: false),
              PageInfo("Cupertino組件", (ctx) => CupertinoTestRoute(), withScaffold: false),
              PageInfo("Widget管理自身狀態", (ctx) => TapboxA(), withScaffold: false),
              PageInfo("父Widget管理子Widget的狀態", (ctx) => ParentWidget(), withScaffold: false),
              PageInfo("混合狀態管理", (ctx) => ParentWidgetC(), withScaffold: false),
              PageInfo("文本、字體樣式", (ctx) => TextRoute()),
              PageInfo("按鈕", (ctx) => ButtonRoute()),
              PageInfo("圖片伸縮", (ctx) => ImageAndIconRoute()),
              PageInfo("單選開關和複選框", (ctx) => SwitchAndCheckBoxRoute()),
              PageInfo("登入輸入框",(ctx) => LoginTestRoute()),
              PageInfo("輸入框",(ctx) => FocusTestRoute()),
              PageInfo("輸入框及表單",(ctx) => FormTestRoute()),
              PageInfo("進度條", (ctx) => ProgressRoute()),
            ]),
          ),
          ExpansionTile(
            title: Text("布局類組件"),
            children: _generateItem(context, [
              PageInfo("Row測試", (ctx) => RowTestRoute()),
              PageInfo("Column居中", (ctx) => CenterColumnRoute()),
              PageInfo("Column再嵌套Column", (ctx) => ColumnNested()),
              PageInfo("Column占滿外部Column", (ctx) => ColumnFullExternalColumn()),
              PageInfo("彈性布局Row、Column", (ctx) => FlexLayoutTestRoute()),
              PageInfo("流式布局Wrap", (ctx) => WrapTestRoute()),
              PageInfo("流式布局Flow", (ctx) => FlowTestRoute()),
              PageInfo("Stack和絕對定位", (ctx) => StackTestRoute()),
              PageInfo("表格布局", (ctx) => TableRoute()),
              PageInfo("對齊及相對定位", (ctx) => AlignRoute()),
            ]),
          ),
          ExpansionTile(
            title: Text("容器类组件"),
            children: _generateItem(context, [
              PageInfo("填充Padding", (ctx) => PaddingTestRoute()),
              PageInfo("尺寸限制類容器", (ctx) => SizeConstraintsRoute(), withScaffold: false),
              PageInfo("DecoratedBox", (ctx) => DecoratedBoxRoute()),
              PageInfo("Transform", (ctx) => TransformTestRoute()),
              PageInfo("Container", (ctx) => ContainerTestRoute()),
              PageInfo("Scaffold、TabBar、底部導航", (ctx) => ScaffoldRoute(), withScaffold: false),
              PageInfo("Clip", (ctx) => ClipTestRoute()),
            ]),
          ),
          ExpansionTile(
            title: Text("可滾動組件"),
            children: _generateItem(context, [
              PageInfo("SingleChildScrollView", (ctx) => SingleChildScrollViewTestRoute()),
              PageInfo("ListView", (ctx) => ListViewTestRoute()),
              PageInfo("ListView.Builder", (ctx) => ListViewBuilderTestRoute()),
              PageInfo("ListView.Separated", (ctx) => ListViewSeparatedTextRoute()),
              PageInfo("縱軸固定數量的GridView", (ctx) => GridViewFixedCrossTestRoute()),
              PageInfo("縱軸子元素為固定長度的GridView", (ctx) => GridViewMaxCrossTestRoute()),
              PageInfo("無限長度的GridView", (ctx) => InfiniteGridView()),
              PageInfo("flutter_staggered_grid_view", (ctx) => FlutterStaggeredGridViewTestRoute(), withScaffold: false),
              PageInfo("CustomScrollView", (ctx) => CustomScrollViewTestRoute(), withScaffold: false),
              PageInfo("滾動控制", (ctx) => ScrollControllerTestRoute(), withScaffold: false),
              PageInfo("滾動監聽", (ctx) => ScrollNotificationTestRoute()),
            ]),
          ),
        ],
      ),
    );
  }
}
