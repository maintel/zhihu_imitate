import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    _tabController.addListener(() => onTabChange());
    _tabController.animation.addListener(() {
      print("_currentAnimValue::${_tabController.animation.value}");
      setState(() {
        _currentAnimValue = _tabController.animation.value;
      });
    });
  }

  void onTabChange() {
    print("${_tabController.animation.value}");
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
                              getTab("关注", 0),
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
            Container(
              child: Center(
                child: Text("bbbb"),
              ),
            ),
            Container(
              child: Center(
                child: Text("cccc"),
              ),
            ),
            Container(
              child: Center(
                child: Text("dddd"),
              ),
            ),
          ]),
        ));
  }

  Widget getTab(String text, int index) {
    return CustomTabWidget(
      text,
      Colors.black,
      Colors.blueGrey,
      16,
      animValue:
          _currentAnimValue >= index + 1 || _currentAnimValue <= index - 1
              ? 0
              : sin(pi / 2 * _currentAnimValue +
                  pi / 2 * ((index + 1) % 2 == 0 ? index - 1 : index + 1)),
    );
  }
}
