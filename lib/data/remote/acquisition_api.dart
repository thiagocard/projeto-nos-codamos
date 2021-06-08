import 'package:http/http.dart' as http;

class AcquisitionApi {

  static const _baseUrl = 'http://localhost:8080/';

  /// Send the country code and receive the acquisition flow
  Future<http.Response> postCountry(String countryCode) {
    return http.post(Uri.parse('$_baseUrl/api/country'));
  }

}