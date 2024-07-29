import 'dart:ui';

import 'package:flutter/material.dart';


Size? screenLogicSize;
const designedUISize = Size(393, 852);
final widthFactor = getScreenWidthFactor(designWidth: designedUISize.width);
final heightFactor = getScreenHeightFactor(designHeight: designedUISize.height);

double getScreenWidthFactor({double? designWidth}) {
  if (screenLogicSize == null) {
    final pixelRatio = window.devicePixelRatio;
    screenLogicSize = window.physicalSize / pixelRatio;
  }

  return screenLogicSize!.width / (designWidth != null ? designWidth! : designedUISize.width);
}

double getScreenHeightFactor({double? designHeight}) {
  if (screenLogicSize == null) {
    final pixelRatio = window.devicePixelRatio;
    screenLogicSize = window.physicalSize / pixelRatio;
  }

  return screenLogicSize!.height / (designHeight != null ? designHeight! : designedUISize.height);
}

class CommonUtils{
  static String getWeatherTitle(String weather){
    switch(weather){
      case "Wx":
        return "天氣現象";
      case "CI":
        return "舒適度";
      case "PoP":
        return "降雨機率";
      case "MinT":
        return "最低溫度";
      case "MaxT":
        return "最高溫度";
      default:
        return weather;
    }
  }
}