import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

class WidgetToImage {

  Future exportToImage(GlobalKey globalKey)async{
    final boundary =
      globalKey.currentContext.findRenderObject() as RenderRepaintBoundary;
    final imge = await boundary.toImage(
      pixelRatio: 3,
    );
    final byteData = await imge.toByteData(
      format: ui.ImageByteFormat.png
    );
    return byteData;
  }
}