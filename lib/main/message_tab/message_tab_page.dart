import 'dart:developer';

import 'package:flutter/material.dart';

class MessageTabPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MessageTabPageState();
  }
  
}

class _MessageTabPageState extends State<MessageTabPage>{
  @override
  Widget build(BuildContext context) {
    log("消息");
    return Center(
      child: Text("消息"),
    );
  }
  
}