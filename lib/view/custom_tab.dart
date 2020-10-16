import 'dart:developer';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

class CustomTabWidget extends StatelessWidget {
  double animValue;
  final String text;
  final double textSize;
  final double scale;
  final Color activeColor;
  final bool active;
  final Color inactiveColor;

  CustomTabWidget(
    this.text,
    this.activeColor,
    this.inactiveColor,
    this.textSize, {
    this.scale = 1.3,
    this.animValue = 0,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    log("animValue:${animValue}");
    var currentTextSize = NumUtil.getNumByValueDouble(
        textSize * (animValue * (scale - 1) + 1), 3);
    log("currentTextSize:${currentTextSize}");

    return Container(
      width: 60,
      height: 50,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: active ? activeColor : inactiveColor,
              fontSize: currentTextSize),
        ),
      ),
    );
  }
}
