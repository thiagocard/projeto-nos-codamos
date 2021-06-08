import 'package:http/http.dart' as http;

class AcquisitionApi {

  static const _baseUrl = 'https://e890bfd8-1c22-485d-ae4b-3bdf47babaf0.mock.pstmn.io/entrypoint/';

  /// Send the country code and receive the acquisition flow
  Future<http.Response> postCountry(String countryCode) {
    return http.post(Uri.parse('$_baseUrl$countryCode'));
  }

}