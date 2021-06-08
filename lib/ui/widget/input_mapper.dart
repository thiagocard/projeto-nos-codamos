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
      case 'number':
        return TextInputType.number;
      case 'datetime':
        return TextInputType.datetime;
      case 'email':
        return TextInputType.emailAddress;
      case 'string':
      default:
        return TextInputType.text;
    }
  }

}
