import 'dart:developer';

import 'package:flutter/material.dart';

class FoundTabPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FoundTabPageState();
  }
}

class _FoundTabPageState extends State<FoundTabPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    log("发现");
    return Center(
      child: Text("发现"),
    );
  }
  
}