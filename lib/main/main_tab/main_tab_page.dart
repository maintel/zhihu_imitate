import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:zhihu_imitate/main/main_tab/second_tab/recommend_page.dart';
import 'package:zhihu_imitate/view/common_view.dart';
import 'package:zhihu_imitate/view/custom_sliver.dart';
import 'package:zhihu_imitate/view/custom_tab.dart';

class MainTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainTabPageState();
  }
}

class _MainTabPageState extends State<MainTabPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  double _currentAnimValue = 0;
  int _currentTab = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    _tabController.addListener(() => onTabChange());
    _tabController.animation.addListener(() {
      setState(() {
        _currentAnimValue = _tabController.animation.value;
      });
    });
  }

  void onTabChange() {
    setState(() {
      _currentTab = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQueryData.fromWindow(window).padding.top),
          child: SafeArea(
            top: true,
            child: Offstage(),
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: SliverAppBar(
                  flexibleSpace: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.access_alarm),
                        Expanded(
                          child: TextField(),
                        ),
                        Icon(Icons.add),
                      ],
                    ),
                  ),
                  pinned: false,
                  floating: true,
                  snap: false,
                  forceElevated: innerBoxIsScrolled,
                ),
              ),
              SliverPersistentHeader(
                delegate: SliverAppBarDelegate(Container(
                  color: Colors.grey,
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TabBar(
                            isScrollable: true,
                            controller: _tabController,
                            tabs: [
                              attentionTab(),
                              getTab("推荐", 1),
                              getTab("热榜", 2),
                              getTab("圈子", 3),
                            ]),
                      ),
                      Icon(Icons.search)
                    ],
                  ),
                )),
                pinned: true,
              )
            ];
          },
          body: TabBarView(controller: _tabController, children: [
            Container(
              child: Center(
                child: Text("aaaa"),
              ),
            ),
            RecommendPage(),
            CardFlipWidget(),
            Container(
              child: Center(
                child: Text("dddd"),
              ),
            ),
          ]),
        ));
  }

  Widget attentionTab() {
    return Container(
      height: 55,
      alignment: Alignment.bottomCenter,
      child: Row(
        children: <Widget>[
          getTab("关注", 0),
          Offstage(
            offstage: _currentTab != 0,
            child: Icon(Icons.accessibility_new),
          )
        ],
      ),
    );
  }

  Widget getTab(String text, int index) {
    return CustomTabWidget(
      text,
      Colors.black,
      Colors.blueGrey,
      14,
      animValue:
          _currentAnimValue >= index + 1 || _currentAnimValue <= index - 1
              ? 0
              : sin(pi / 2 * _currentAnimValue +
                  pi / 2 * ((index + 1) % 2 == 0 ? index - 1 : index + 1)),
    );
  }
}
