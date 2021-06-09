import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nos_codamos/data/model/acquisition_flow.dart';
import 'package:nos_codamos/data/remote/acquisition_api.dart';
import 'package:nos_codamos/data/repository/acquisition_repository.dart';
import 'package:http/http.dart' as http;
import 'acquisition_repository_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  test('Should get the acquisition flow with success', () async {
    var client = MockClient();
    var api = AcquisitionApi(client);
    var repo = AcquisitionRepositoryImpl(api);

    var body = File('test/assets/response_get_acquisition_flow.json')
        .readAsStringSync();
    when(client.get(any)).thenAnswer((_) async => Response(body, 200));

    var acquisitionFlow = await repo.getAcquisitionFlow('br');

    expect(acquisitionFlow.pages.length, 4);
    expect(acquisitionFlow.pages[0].children[0].type, BdcComponent.header);
    // ... demais asserts
  });
}
