import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

Widget userCenterTitleDivdingLine() {
  return Container(
    margin: EdgeInsets.only(top: 5),
    child: DividingLine(
      Colors.grey[300],
      height: 15,
      widget: 0.5,
    ),
  );
}

class DividingLine extends StatelessWidget {
  double height = 0;
  double widget;
  Color _color;

  DividingLine(this._color, {this.height = 0, this.widget = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: widget,
      color: _color,
    );
  }
}

// 滑动移除卡片
// class DragRemoveCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//           Dismissible(child: null, feedback: null)
//       ],
//     );
//   }
// }
