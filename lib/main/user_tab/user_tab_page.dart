import 'dart:developer';

import 'package:flutter/material.dart';

class UserTabPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _UserTabPageState();
  }
  
}

class _UserTabPageState extends State<UserTabPage>{
  @override
  Widget build(BuildContext context) {
    log("我的");
    return Center(
      child: Text("我的"),
    );
  }
  
}