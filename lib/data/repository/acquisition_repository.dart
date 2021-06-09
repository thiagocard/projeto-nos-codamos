import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Response;
import 'package:nos_codamos/data/model/acquisition_flow.dart';
import 'package:nos_codamos/data/model/bottom_button.dart';
import 'package:nos_codamos/data/model/header.dart';
import 'package:nos_codamos/data/model/image.dart';
import 'package:nos_codamos/data/model/input.dart';
import 'package:nos_codamos/data/model/welcome.dart';
import 'package:nos_codamos/data/remote/acquisition_api.dart';

abstract class AcquisitionRepository {
  Future<AcquisitionFlow> getAcquisitionFlow(String countryCode);

  Future<AcquisitionFlow> doAction(
      BdcBottomButtonAction action, Map<String, String> params);

  getWelcome();
}

class AcquisitionRepositoryImpl extends AcquisitionRepository {
  final AcquisitionApi _api;

  AcquisitionRepositoryImpl(this._api);

  @override
  Future<AcquisitionFlow> getAcquisitionFlow(String countryCode) async {
    final response = await _api.get(countryCode);
    return handleResponse(response);
  }

  AcquisitionFlow handleResponse(Response response) {
    debugPrint('Response: ${response.body}');
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
      return AcquisitionFlow(bdcPages);
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
        return BdcInput(id: item['id'], keyboard: item['keyboard'], format: item['format']);
      case BdcComponent.image:
        return BdcImage(name: item['name']);
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
  Future<AcquisitionFlow> doAction(
      BdcBottomButtonAction action, Map<String, String> params) async {
    switch (action.method) {
      case 'post':
        return handleResponse(await _api.post(action.uri, params));
      case 'get':
        return handleResponse(await _api.get(action.uri));
      default:
        throw UnimplementedError();
    }
  }

  @override
  Future<WelcomeData> getWelcome() async {
    final response = await _api.get("welcome");
    if (response.statusCode == 200) {
      var content = jsonDecode(response.body);
      return WelcomeData(content);
    }
    return WelcomeData(null);
  }
}
