import 'package:flutter/material.dart';
import 'package:nos_codamos/data/model/bottom_button.dart';
import 'package:nos_codamos/data/model/image.dart';
import 'package:nuds_mobile/nuds_mobile.dart';

class ImageWidgetMapper {
  ImageWidgetMapper._();

  static Image map(BdcImage bdcImage) {
    return Image(image: NuDSImages.byName(bdcImage.src));
  }
}
