import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AcquisitionApi {

  static const _baseUrl = 'https://e890bfd8-1c22-485d-ae4b-3bdf47babaf0.mock.pstmn.io/entrypoint/';

  /// Send the country code and receive the acquisition flow
  Future<http.Response> postCountry(String countryCode) async {
    debugPrint(Uri.parse('$_baseUrl$countryCode').toString());
    try {
      debugPrint('try');
      var data = await http.get(Uri.parse('$_baseUrl$countryCode'));
      debugPrint("Status code ${data.statusCode}");
      debugPrint("Body ${data.body}");
      return data;
    } catch(e) {
      debugPrint("Error with get country");
      debugPrint(e.toString());
    }
  }

}