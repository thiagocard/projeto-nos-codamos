import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;

class AcquisitionApi {
  static get _baseUrl =>
      Platform.isAndroid ? 'http://10.0.2.2:9000' : 'https://4c3f7d4e1881.ngrok.io';

  final http.Client _httpClient;

  AcquisitionApi(this._httpClient);

  Future<http.Response> get(String uri) async {
    try {
      var response = await _httpClient.get(Uri.parse('$_baseUrl$uri'));
      return response;
    } catch (e) {
      debugPrint("Error in get country");
    }
    return null;
  }

  Future<http.Response> post(String uri, Map<String, String> body) async {
    String bodyJSON = jsonEncode(body);
    print("Body Request:" + bodyJSON);
    try {
      var response = await http.post(Uri.parse('$_baseUrl$uri'), body: bodyJSON);
      return response;
    } catch (e) {
      debugPrint("Error in post $_baseUrl$uri");
      debugPrint(e.toString());
    }
    return null;
  }
}
