import 'package:flutter/material.dart';
import 'package:flutter_in_action/routes/router.dart';
import 'package:flutter_in_action/widgets/page_scaffold.dart';

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
        ],
      ),
    );
  }
}
