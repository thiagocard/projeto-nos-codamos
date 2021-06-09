import 'package:flutter/material.dart';
import 'package:nos_codamos/data/model/header.dart';
import 'package:nuds_mobile/nuds_mobile.dart';

class HeaderWidgetMapper {

  HeaderWidgetMapper._();

  static Header map(BdcHeader bdcHeader) {
    return Header(
      title: Text(bdcHeader.title),
      subtitle: bdcHeader.subtitle != null ? Text(bdcHeader.subtitle) : null,
    );
  }

}