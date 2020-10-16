import 'dart:developer';

import 'package:flutter/material.dart';

class VipTabPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VipTabPageState();
  }
  
  
}

class _VipTabPageState extends State<VipTabPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    log("会员");
    return Center(
      child: Text("会员"),
    );
  }
  
}