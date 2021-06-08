import 'dart:convert';

import 'package:nos_codamos/data/model/acquisition_flow.dart';
import 'package:nos_codamos/data/model/bottom_button.dart';
import 'package:nos_codamos/data/model/header.dart';
import 'package:nos_codamos/data/model/input.dart';
import 'package:nos_codamos/data/remote/acquisition_api.dart';

abstract class AcquisitionRepository {
  Future<void> postCountry(String countryCode);

  Future<void> doAction(
      BdcBottomButtonAction action, Map<String, String> params);
}

class AcquisitionRepositoryImpl extends AcquisitionRepository {
  final AcquisitionApi _api;
  AcquisitionFlow acquisitionFlow;

  AcquisitionRepositoryImpl(this._api);

  @override
  Future<void> postCountry(String countryCode) async {
    final response = await _api.get(countryCode);
    if (response.statusCode == 200) {
      final screen = jsonDecode(response.body);
      final List pages = screen['pages'];

      List<BdcPage> bdcPages = pages.map((page) {
        final List children = page['children'];
        final List<BdcComponent> childComponents =
            children.map((child) => mapComponent(child)).toList();
        final bottom = page['bottom'];
        BdcBottomButton bottomComponent =
            (bottom != null) ? mapComponent(bottom) : null;
        return BdcPage(childComponents, bottomComponent);
      }).toList();
      acquisitionFlow = AcquisitionFlow(bdcPages);
    } else {
      return null;
    }
  }

  BdcComponent mapComponent(Map<String, dynamic> item) {
    final type = item['type'];
    switch (type) {
      case BdcComponent.header:
        return BdcHeader(title: item['title'], subtitle: item['subtitle']);
      case BdcComponent.input:
        return BdcInput(id: item['id'], keyboard: item['keyboard']);
      case BdcComponent.bottomButton:
        return BdcBottomButton(
            text: item['text'],
            action: item['action'] != null
                ? BdcBottomButtonAction(
                    method: item['action']['method'],
                    uri: item['action']['uri'],
                    steps: List<String>.from(item['action']['steps']))
                : null);
      default:
        throw Exception('Cant\'t handle item of type $type');
    }
  }

  @override
  Future<void> doAction(
      BdcBottomButtonAction action, Map<String, String> params) {
    switch (action.method) {
      case 'post':
        return _api.post(action.uri, params);
      case 'get':
        return _api.get(action.uri);
      default:
        throw UnimplementedError();
    }
  }
}
