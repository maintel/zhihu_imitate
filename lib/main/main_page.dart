import 'package:flutter/material.dart';
import 'package:zhihu_imitate/main/found_tab/found_tab_page.dart';
import 'package:zhihu_imitate/main/main_tab/main_tab_page.dart';
import 'package:zhihu_imitate/main/message_tab/message_tab_page.dart';
import 'package:zhihu_imitate/main/user_tab/user_tab_page.dart';
import 'package:zhihu_imitate/main/vip_tab/vip_tab_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  final List<BottomNavigationBarItem> bottomBarItem = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text("首页"), 
        backgroundColor: Colors.red,
        activeIcon: Icon(Icons.ac_unit)),
    BottomNavigationBarItem(
        icon: Icon(Icons.verified_user),
        title: Text("会员"),
        backgroundColor: Colors.red),
    BottomNavigationBarItem(
        icon: Icon(Icons.map), title: Text("发现"), 
        backgroundColor: Colors.red),
    BottomNavigationBarItem(
        icon: Icon(Icons.message),
        title: Text("消息"),
        backgroundColor: Colors.red),
    BottomNavigationBarItem(
        icon: Icon(Icons.supervised_user_circle),
        title: Text("我的"),
        backgroundColor: Colors.red),
  ];

  final List<Widget> pages = [
    MainTabPage(),
    VipTabPage(),
    FoundTabPage(),
    MessageTabPage(),
    UserTabPage()
  ];

  var _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: bottomBarItem,
        currentIndex: _currentIndex,
         type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (_currentIndex != index) {
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          }
        },
      ),
      // body: pages[_currentIndex],  // 使用这种方式每次切换都会执行 reBuild
      body: PageView(
        controller: _controller,
        children: pages,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
