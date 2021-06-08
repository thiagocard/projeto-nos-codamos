import 'package:flutter/material.dart';
import 'package:nos_codamos/data/model/input.dart';
import 'package:nuds_mobile/nuds_mobile.dart';

class InputWidgetMapper {
  InputWidgetMapper._();

  static InputText map(BdcInput bdcInput, TextEditingController controller) {
    return InputText(
      key: Key(bdcInput.id),
      keyboardType: _keyboardType(bdcInput.keyboard),
      controller: controller,
    );

  }

  static _keyboardType(String keyboard) {
    switch (keyboard) {
      case 'number':
        return TextInputType.number;
      case 'string':
      default:
        return TextInputType.text;
    }
  }

}
