import 'dart:convert';

import 'package:nos_codamos/data/model/acquisition_flow.dart';
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
    final screen = jsonDecode(response.body);
    final List body = screen['children'];
    final bottom = screen['bottom'];
    
    body.forEach((element) { })
    
    return AcquisitionFlow();
  }

}