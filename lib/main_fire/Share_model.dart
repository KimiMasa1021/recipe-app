import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:tea_select/main_fire/wiget_to_img.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';


class ShareProvider {

  Future<void> shareImageAndText(String text, GlobalKey globalKey) async {

    try{
      final ByteData bytes = await WidgetToImage().exportToImage(globalKey);
      await Share.file(
          'shared image', 'share.png', bytes.buffer.asUint8List(), 'image/png',
          text: text);
    }catch(error){
      print('レシピシェア:$error');
    }


  }
}