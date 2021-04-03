import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DialogTestRoute extends StatefulWidget {
  @override
  _DialogTestRouteState createState() => _DialogTestRouteState();
}

class _DialogTestRouteState extends State<DialogTestRoute> {
  bool withTree = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ElevatedButton(
              child: Text("對話框1"),
              onPressed: () async {
                bool delete = await showDeleteConfirmDialog1();
                if (delete == null) {
                  print("取消刪除");
                } else {
                  print("已確認刪除");
                }
              }),
          ElevatedButton(
            child: Text("對話框2"),
            onPressed: () async {
              bool delete = await showDeleteConfirmDialog2();
              if (delete == null) {
                print("取消刪除");
              } else {
                print("同時刪除子目錄：$delete");
              }
            },
          ),
          ElevatedButton(
            child: Text("話框3（複選框可點擊）"),
            onPressed: () async {
              bool deleteTree = await showDeleteConfirmDialog3();
              if (deleteTree == null) {
                print("取消刪除");
              } else {
                print("同時刪除子目錄：$deleteTree");
              }
            },
          ),
          ElevatedButton(
            child: Text("話框3x（複選框可點擊）"),
            onPressed: () async {
              bool deleteTree = await showDeleteConfirmDialog3x();
              if (deleteTree == null) {
                print("取消刪除");
              } else {
                print("同時刪除子目錄：$deleteTree");
              }
            },
          ),
          ElevatedButton(
            child: Text("話框4（複選框可點擊）"),
            onPressed: () async {
              bool deleteTree = await showDeleteConfirmDialog4();
              if (deleteTree == null) {
                print("取消刪除");
              } else {
                print("同時刪除子目錄：$deleteTree");
              }
            },
          ),
          ElevatedButton(
            child: Text("選擇語言"),
            onPressed: () {
              changeLanguage();
            },
          ),
          ElevatedButton(
            child: Text("顯示列表對話框"),
            onPressed: () {
              showListDialog();
            },
          ),
          ElevatedButton(
            child: Text("自定義對話框"),
            onPressed: () async {
              bool deleteTree = await showDeleteConfirmDialog5();
              if (deleteTree == null) {
                print("取消刪除");
              } else {
                print("已確認刪除");
              }
            },
          ),
          ElevatedButton(
            child: Text("顯示底部菜單列表（模態）"),
            onPressed: () async {
              int type = await _showModalBottomSheet();
              print(type);
            },
          ),
          ElevatedButton(
            child: Text("顯示底部菜單列表（非模態）"),
            onPressed: () async {
              _showBottomSheet();
            },
          ),
          ElevatedButton(
            child: Text("顯示Loading框"),
            onPressed: () async {
              showLoadingDialog();
            },
          ),
          ElevatedButton(
            child: Text("打開Material風格的日曆選擇框"),
            onPressed: () async {
              _showDatePicker1();
            },
          ),
          ElevatedButton(
            child: Text("打開iOS風格的日曆選擇框"),
            onPressed: () async {
              _showDatePicker2();
            },
          ),
        ],
      ),
    );
  }

  Future<bool> showDeleteConfirmDialog1() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您確定要刪除當前文件嗎?"),
          actions: <Widget>[
            TextButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(), // 關閉對話框
            ),
            TextButton(
              child: Text("刪除"),
              onPressed: () {
                // 關閉對話框並返回true
                Navigator.of(context).pop(true);
              },
            )
          ],
        );
      },
    );
  }

  Future<bool> showDeleteConfirmDialog2() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("您確定要刪除當前文件嗎？"),
              Row(
                children: <Widget>[
                  Text("同時刪除子目錄？"),
                  Checkbox(
                      value: withTree,
                      onChanged: (bool value) {
                        setState(() {
                          withTree = !withTree;
                        });
                      }),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("刪除"),
              onPressed: () {
                // 執行刪除操作
                Navigator.of(context).pop(withTree);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> showDeleteConfirmDialog3() {
    bool _withTree = false;
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("您確定要刪除當前文件嗎？"),
                Row(
                  children: <Widget>[
                    Text("同時刪除子目錄？"),
                    DialogCheckbox(
                        value: _withTree,
                        onChanged: (bool value) {
                          _withTree = !_withTree;
                        }),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text("取消"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text("刪除"),
                onPressed: () {
                  // 執行刪除操作
                  Navigator.of(context).pop(_withTree);
                },
              ),
            ],
          );
        });
  }

  Future<bool> showDeleteConfirmDialog3x() {
    bool _withTree = false;
    print(defaultTargetPlatform);
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("您確定要刪除當前文件嗎？"),
                  Row(
                    children: <Widget>[
                      Text("同時刪除子目錄？"),
                      Checkbox(
                          value: _withTree,
                          onChanged: (bool value) {
                            setState(() {
                              _withTree = !_withTree;
                            });
                          }),
                    ],
                  ),
                ],
              );
            }),
            actions: <Widget>[
              TextButton(
                child: Text("取消"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text("刪除"),
                onPressed: () {
                  // 執行刪除操作
                  Navigator.of(context).pop(_withTree);
                },
              ),
            ],
          );
        });
  }

  Future<bool> showDeleteConfirmDialog4() {
    bool _withTree = false;
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("您確定要刪除當前文件嗎？"),
                Row(
                  children: <Widget>[
                    Text("同時刪除子目錄？"),
                    Builder(builder: (BuildContext context) {
                      return Checkbox(
                          value: _withTree,
                          onChanged: (bool value) {
                            // 此時context為對話框UI的根Element，我們
                            // 直接將對話框UI對應的Element標記為dirty
                            (context as Element).markNeedsBuild();
                            _withTree = !_withTree;
                          });
                    }),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text("取消"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text("刪除"),
                onPressed: () {
                  // 執行刪除操作
                  Navigator.of(context).pop(_withTree);
                },
              ),
            ],
          );
        });
  }

  Future<bool> showDeleteConfirmDialog5() {
    return showCustomDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您確定要刪除當前文件嗎？"),
          actions: <Widget>[
            TextButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("删除"),
              onPressed: () {
                // 執行删除操作
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  Future<int> _showModalBottomSheet() {
    return showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text("$index"),
              onTap: () => Navigator.of(context).pop(index),
            );
          },
        );
      },
    );
  }

  PersistentBottomSheetController<int> _showBottomSheet() {
    return showBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
            itemCount: 30,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text("$index"),
                onTap: () {
                  print("$index");
                  Navigator.of(context).pop();
                },
              );
            });
      },
    );
  }

  Future<void> changeLanguage() async {
    int i = await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text("請選擇語言"),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 1);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text("中文繁體"),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 2);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text("美國英語"),
                ),
              ),
            ],
          );
        });

    if (i != null) {
      print("選擇了：${i == 1 ? "中文繁體" : "美國英語"}");
    }
  }

  Future<void> showListDialog() async {
    int index = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        var child = Column(
          children: <Widget>[
            ListTile(title: Text("請選擇")),
            Expanded(
              child: ListView.builder(
                  itemCount: 30,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text("$index"),
                      onTap: () => Navigator.of(context).pop(index),
                    );
                  }),
            ),
          ],
        );
        //使用AlertDialog會報錯
        //return AlertDialog(content: child);
        return Dialog(child: child);
      },
    );
    if (index != null) {
      print("點擊了：$index");
    }
  }

  showLoadingDialog() {
    showDialog(
        context: context,
        barrierDismissible: false, // 點擊遮罩不關閉對話框
        builder: (context) {
          return UnconstrainedBox(
            constrainedAxis: Axis.vertical,
            child: SizedBox(
              width: 280,
              child: AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: const EdgeInsets.only(top: 26.0),
                      child: Text("正在加載，請稍後……"),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<DateTime> _showDatePicker1() {
    var date = DateTime.now();
    return showDatePicker(
        context: context,
        initialDate: date,
        firstDate: date,
        lastDate: date.add(
          Duration(days: 30),
        ));
  }

  Future<DateTime> _showDatePicker2() {
    var date = DateTime.now();
    return showCupertinoModalPopup(
        context: context,
        builder: (ctx) {
          return SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              backgroundColor: Colors.white,
              mode: CupertinoDatePickerMode.dateAndTime,
              minimumDate: date,
              maximumDate: date.add(
                Duration(days: 30),
              ),
              maximumYear: date.year + 1,
              onDateTimeChanged: (DateTime value) {
                print(value);
              },
            ),
          );
        });
  }

  Future<T> showCustomDialog<T>({
    @required BuildContext context,
    bool barrierDismissible = true,
    WidgetBuilder builder,
  }) {
    // final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
    final ThemeData theme = Theme.of(context);
    return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        final Widget pageChild = Builder(builder: builder);
        return SafeArea(
          child: Builder(
            builder: (BuildContext context) {
              return theme != null
                  ? Theme(data: theme, child: pageChild)
                  : pageChild;
            },
          ),
        );
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black87,
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: _buildMaterialDialogTransitions,
    );
  }

  Widget _buildMaterialDialogTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    // 使用縮放動畫
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }
}

class DialogCheckbox extends StatefulWidget {
  DialogCheckbox({
    Key key,
    this.value,
    @required this.onChanged,
  });

  final ValueChanged<bool> onChanged;
  final bool value;

  @override
  _DialogCheckboxState createState() => _DialogCheckboxState();
}

// 單獨封裝一個內部管理選中狀態的複選框組件
class _DialogCheckboxState extends State<DialogCheckbox> {
  bool value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (v) {
        // 將選中狀態通過事件的形式拋出
        widget.onChanged(v);
        setState(() {
          // 更新自身選中狀態
          value = v;
        });
      },
    );
  }
}
