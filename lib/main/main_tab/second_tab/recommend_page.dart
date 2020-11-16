import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RecommendPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RecommendPageState();
  }
}

class _RecommendPageState extends State<RecommendPage> {
  List<Map<String, String>> _list = [
    {"title": "AAAAA", "subTitle": "aaaaa"},
    {"title": "BBBBB", "subTitle": "aaaaa"},
    {"title": "CCCCC", "subTitle": "aaaaa"},
    {"title": "DDDDD", "subTitle": "aaaaa"},
    {"title": "EEEEE", "subTitle": "aaaaa"},
    {"title": "FFFFF", "subTitle": "aaaaa"},
    {"title": "GGGGG", "subTitle": "aaaaa"}
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _list.length,
      itemBuilder: (BuildContext context, int index) {
        final item = _list[index];
        return Dismissible(
          key: Key(item.toString()),
          // crossAxisEndOffset: 1.0,
          // secondaryBackground: Container(color: Colors.pink),
          dragStartBehavior: DragStartBehavior.down,
          direction: DismissDirection.endToStart,
          background: Container(color: Colors.red),
          child: ListTile(
            title: Text(item['title']),
            subtitle: Text(item['subTitle']),
          ),
          onDismissed: (direction) {
            setState(() {
              _list.removeAt(index);
              print(_list.length);
            });
            Scaffold.of(context).hideCurrentSnackBar();
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('删除成功...'),
            ));
          },
        );
      },
    );
    ;
  }
}
