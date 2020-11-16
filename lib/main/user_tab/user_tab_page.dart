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
      backgroundColor: Colors.grey[300],
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
                    Stack(
                      children: <Widget>[
                        //vip 卡片
                        _vipWidget(),
                        //个人中心卡片
                        _userInfoWidget(),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        _toolsWidget()
      ]),
    );
  }

  // 工具金刚位
  Widget _toolsWidget() {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        margin: EdgeInsets.all(10),
        child: GridView.builder(
            shrinkWrap: true,
            itemCount: 8,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 60.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 20.0,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.account_balance_wallet),
                    Text("index:$index")
                  ],
                ),
              );
            }),
      ),
    );
  }

  //个人信息卡片
  Widget _userInfoWidget() {
    return Container(
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        padding: EdgeInsets.only(
                            top: 2, left: 4, right: 4, bottom: 2),
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
    );
  }

  // vip 区域
  Widget _vipWidget() {
    return Container(
      // transform: Matrix4.translationValues(0, -10, 0),
      padding: EdgeInsets.only(top: 15),
      margin: EdgeInsets.only(top: 130, left: 10, right: 10),
      decoration: BoxDecoration(
          color: Colors.amber[200],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
      child: Row(
        children: <Widget>[
          _vipWidgetText("精选会员内容", "为你严选好内容"),
          Container(
            color: Colors.amber[400],
            width: 0.5,
            height: 30,
          ),
          _vipWidgetText("我的盐选会员", "还有10天到期，立即续费")
        ],
      ),
    );
  }

  Widget _vipWidgetText(String title, String label) {
    return Expanded(
        child: Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "$title >",
            style: TextStyle(
                fontSize: 14,
                color: Colors.brown[800],
                fontWeight: FontWeight.w500),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 10, color: Colors.amber[600]),
          )
        ],
      ),
    ));
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
