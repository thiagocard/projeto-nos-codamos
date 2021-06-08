import 'package:flutter/material.dart';
import 'package:nos_codamos/data/model/bottom_button.dart';
import 'package:nuds_mobile/nuds_mobile.dart';

class BottomButtonWidgetMapper {

  BottomsButtonWidgetMapper._();

  static BottomBar map(BdcBottomButton bdcBottomButton, onPress) {
    return BottomBar(primary: BottomBarAction(onPressed: onPress, child: Text(bdcBottomButton.text,)));
  }
}
