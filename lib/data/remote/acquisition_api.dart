import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AcquisitionApi {

  static const _baseUrl = 'https://e890bfd8-1c22-485d-ae4b-3bdf47babaf0.mock.pstmn.io/entrypoint/';


  Future<http.Response> get(String uri) async {
    try {
      var response = await http.get(Uri.parse('$_baseUrl$uri'));
      // debugPrint("Status code ${data.statusCode}");
      // debugPrint("Body ${data.body}");
      return response;
    } catch(e) {
      debugPrint("Error in get country");
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response> post(String uri, Map<String,String> body) async {
    debugPrint("Call post");
    print(body.toString());
    try {
      var response = await http.post(Uri.parse('$_baseUrl$uri'), body: body);
      return response;
    } catch(e) {
      debugPrint("Error in post $_baseUrl$uri");
      debugPrint(e.toString());
    }
    return null;
  }

}