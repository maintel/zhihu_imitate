import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:zhihu_imitate/utils/common_utils.dart';
import 'package:zhihu_imitate/view/image_view.dart';
import 'package:zhihu_imitate/view/common_view.dart';

class UserTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserTabPageState();
  }
}

class _UserTabPageState extends State<UserTabPage> {
  @override
  Widget build(BuildContext context) {
    log("我的");
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverToBoxAdapter(
          child: Stack(
            children: <Widget>[
              Container(
                height: 200,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.blue[500],
                    gradient: LinearGradient(colors: [
                      Colors.blue[500],
                      Colors.blue[500],
                      Colors.blue[500],
                      Colors.blue[500],
                      Colors.blue[400],
                      Colors.blue[300]
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60))),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.access_alarm),
                        Expanded(
                          child: TextField(),
                        ),
                        Icon(Icons.add),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: CircleImage(
                                  "icon_dog_grey.webp",
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                              Expanded(
                                  child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        "maintel",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Icon(Icons.ac_unit)
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(top: 4),
                                        decoration: BoxDecoration(
                                            color: Colors.blue[50],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        padding: EdgeInsets.only(
                                            top: 2,
                                            left: 4,
                                            right: 4,
                                            bottom: 2),
                                        child: Text(
                                          "知乎盐值：199",
                                          style: TextStyle(
                                              color: Colors.blue[600],
                                              fontSize: 9,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )),
                              Text("个人主页")
                            ],
                          ),
                          Container(
                            height: 20,
                          ),
                          _titleCardItemList(),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  Widget _titleCardItemList() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _titleCardItem("未开通", "创作中心", () {},
            titleSize: 10,
            titleColor: Colors.blue[500],
            titleFontWidget: FontWeight.normal),
        userCenterTitleDivdingLine(),
        _titleCardItem("11", "关注", () {}),
        userCenterTitleDivdingLine(),
        _titleCardItem("3", "收藏夹", () {}),
        userCenterTitleDivdingLine(),
        _titleCardItem("1000", "最近浏览", () {}),
      ],
    );
  }

  Widget _titleCardItem(String title, String label, GestureTapCallback onTap,
      {Color titleColor = Colors.black,
      Color labelColor = Colors.black,
      double titleSize = 14,
      double labelSize = 10,
      FontWeight titleFontWidget = FontWeight.bold}) {
    return Expanded(
        child: GestureDetector(
      onTap: () {},
      child: Column(
        children: <Widget>[
          Container(
            height: 22,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                    color: titleColor,
                    fontSize: titleSize,
                    fontWeight: titleFontWidget),
              ),
            ),
          ),
          Text(
            label,
            style: TextStyle(
                color: labelColor,
                fontSize: labelSize,
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    ));
  }
}
