import 'package:flutter/material.dart';
import 'package:nos_codamos/data/model/input.dart';
import 'package:nuds_mobile/nuds_mobile.dart';

class InputWidgetMapper {
  InputWidgetMapper._();

  static Widget map(BdcInput bdcInput, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacings.x6),
      child: InputText(
        key: Key(bdcInput.id),
        keyboardType: _keyboardType(bdcInput.keyboard),
        controller: controller,
      ),
    );
  }

  static _keyboardType(String keyboard) {
    switch (keyboard) {
      case BdcInput.keyobardNumber:
        return TextInputType.number;
      case BdcInput.keyobardDateTime:
        return TextInputType.datetime;
      case BdcInput.keyobardEmail:
        return TextInputType.emailAddress;
      case BdcInput.keyobardString:
      default:
        return TextInputType.text;
    }
  }
}
