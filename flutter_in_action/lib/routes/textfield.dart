import 'package:flutter/material.dart';

class FocusTestRoute extends StatefulWidget {
  @override
  _FocusTestRouteState createState() => _FocusTestRouteState();
}

class _FocusTestRouteState extends State<FocusTestRoute> {
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusScopeNode _focusScopeNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TextField(
            autofocus: true,
            focusNode: _focusNode1, // 關聯focusNode1
            decoration: InputDecoration(labelText: "input1"),
          ),
          TextField(
            focusNode: _focusNode2, // 關聯focusNode2
            decoration: InputDecoration(labelText: "input2"),
            textInputAction: TextInputAction.search,
          ),
          Builder(builder: (ctx) {
            return Column(
              children: <Widget>[
                ElevatedButton(
                    child: Text("移動焦點"),
                    onPressed: () {
                      if (null == _focusScopeNode) {
                        _focusScopeNode = FocusScope.of(context);
                      }
                      _focusScopeNode.requestFocus(_focusNode2);
                    }),
                ElevatedButton(
                  child: Text("隱藏鍵盤"),
                  onPressed: () {
                    _focusNode1.unfocus();
                    _focusNode2.unfocus();
                  },
                ),
              ],
            );
          })
        ],
      ),
    );
  }
}

class LoginTestRoute extends StatefulWidget {
  @override
  _LoginTestRouteState createState() => _LoginTestRouteState();
}

class _LoginTestRouteState extends State<LoginTestRoute> {
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  TextEditingController _selectionController = TextEditingController();

  @override
  void initState() {
    _pwdController.addListener(() {
      print(_pwdController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          autofocus: true,
          controller: _unameController,
          decoration: InputDecoration(
            labelText: "用戶名",
            hintText: "用戶名或郵件",
            prefixIcon: Icon(Icons.person),
          ),
        ),
        TextField(
          controller: _pwdController,
          decoration: InputDecoration(
            labelText: "密碼",
            hintText: "您的登錄密碼",
            prefixIcon: Icon(Icons.lock),
          ),
          obscureText: true,
        ),
        TextField(
          controller: _selectionController,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              child: Text("送出"),
              onPressed: () {
                print(_unameController.text);

                _selectionController.text = "hello world!";
                _selectionController.selection = TextSelection(
                    baseOffset: 2,
                    extentOffset: _selectionController.text.length);
              },
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              )),
        ),
      ],
    );
  }
}

class FormTestRoute extends StatefulWidget {
  @override
  _FormTestRouteState createState() => _FormTestRouteState();
}

class _FormTestRouteState extends State<FormTestRoute> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 24.0),
      child: Form(
        key: _formKey,
        // autovalidate: true,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: <Widget>[
            TextFormField(
              autofocus: true,
              controller: _unameController,
              decoration: InputDecoration(
                labelText: "用戶名",
                hintText: "用戶名或郵件",
                icon: Icon(Icons.person),
              ),
              validator: (v) {
                return v.trim().length > 0 ? null : "用戶名不能為空";
              },
            ),
            TextFormField(
              controller: _pwdController,
              decoration: InputDecoration(
                labelText: "密碼",
                hintText: "您的登錄密碼",
                icon: Icon(Icons.lock),
              ),
              obscureText: true,
              validator: (v) {
                return v.trim().length > 5 ? null : "密碼不能少於6位";
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("登入(使用GlobalKey)",
                            style: TextStyle(fontSize: 14.0),
                            textAlign: TextAlign.center),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        onPrimary: Colors.white,
                      ),
                      onPressed: () {
                        // 在這裡不能通過此方式獲取FormState，context不對
                        // print(Form.of(context))

                        // 通過_formKey.currentState獲取FormState後，
                        // 調用validate()方法校驗用戶名密碼是否合法，校驗通過後再提交數據
                        if ((_formKey.currentState as FormState).validate()) {
                          // 驗證通過提交數據
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        return ElevatedButton(
                          child: Text("登入"),
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            onPrimary: Colors.white,
                          ),
                          onPressed: () {
                            // 使用builder取得FormState
                            if (Form.of(context).validate()) {
                              // 驗證通過提交數據
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
