import 'package:flutter/material.dart';

class SizeConstraintsRoute extends StatelessWidget {
  Widget redBox = DecoratedBox(
    decoration: BoxDecoration(color: Colors.red),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("尺寸限制類容器"),
        actions: <Widget>[
          UnconstrainedBox(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                value: .9,
                valueColor: AlwaysStoppedAnimation(Colors.white70),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: double.infinity, // 寬度盡可能大
                minHeight: 50.0, // 最小高度為50像素
              ),
              child: Container(
                height: 5.0,
                child: redBox,
              ),
            ),
            SizedBox(
              width: 80.0,
              height: 80.0,
              child: redBox,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(minWidth: 60.0, minHeight: 60.0),
              // 父
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0),
                // 子
                child: redBox,
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: 60.0, minHeight: 60.0),
                child: redBox,
              ),
            ),
            ConstrainedBox(
                constraints: BoxConstraints(minWidth: 60.0, minHeight: 100.0),
                //父
                child: UnconstrainedBox(
                  //“去除”父级限制
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minWidth: 90.0, minHeight: 20.0), //子
                    child: redBox,
                  ),
                )),
            AspectRatio(
              aspectRatio: 3, // 寬是高的三倍
              child: redBox,
            )
          ]
              .map((e) => Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: e,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
