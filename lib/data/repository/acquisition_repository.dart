import 'dart:convert';

import 'package:nos_codamos/data/model/acquisition_flow.dart';
import 'package:nos_codamos/data/model/bottom_button.dart';
import 'package:nos_codamos/data/model/header.dart';
import 'package:nos_codamos/data/model/input.dart';
import 'package:nos_codamos/data/remote/acquisition_api.dart';

abstract class AcquisitionRepository {
  Future<AcquisitionFlow> postCountry(String countryCode);
}

class AcquisitionRepositoryImpl extends AcquisitionRepository {

  final AcquisitionApi _api;

  AcquisitionRepositoryImpl(this._api);

  @override
  Future<AcquisitionFlow> postCountry(String countryCode) async {
    final response = await _api.postCountry(countryCode);
    if (response.statusCode == 200) {
      final screen = jsonDecode(response.body);
      final List pages = screen['pages'];
      List<BdcPage> bdcPages = pages.map((page) {
        final List children = page['children'];
        final List<BdcComponent> childComponents = children.map((child) {
          mapComponent(child);
        }).toList();
        final bottom = page['bottom'];
        if (bottom != null) {
          final bottomComponent = mapComponent(bottom);
          childComponents.add(bottomComponent);
        }
        return BdcPage(childComponents);
      });
      return AcquisitionFlow(bdcPages);
    } else {
      return null;
    }
  }

  BdcComponent mapComponent(Map<String, dynamic> item) {
    final type = item['type'];
    switch(type) {
      case BdcComponent.header:
        return BdcHeader(title: item['title'], subtitle: item['subtitle']);
      case BdcComponent.input:
        return BdcInput(id: item['title'], placeholder: item['subtitle']);
      case BdcComponent.bottomButton:
        return BdcBottomButton(text: item['title'], style: item['subtitle']);
      default: throw Exception('Cant\'t handle item of type $type');
    }
  }

}