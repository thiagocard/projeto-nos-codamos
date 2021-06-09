import 'package:flutter/material.dart';
import 'package:nos_codamos/data/model/acquisition_flow.dart';
import 'package:nos_codamos/data/model/bottom_button.dart';
import 'package:nos_codamos/data/remote/acquisition_api.dart';
import 'package:nos_codamos/data/repository/acquisition_repository.dart';

class AcquisitionFlowModel extends ChangeNotifier {

  final AcquisitionRepository _repository = AcquisitionRepositoryImpl(AcquisitionApi());
  final Map<String, String> params = {};
  AcquisitionFlow flow;
  String locale = 'br';

  Future<AcquisitionFlow> fetchAcquisitionFlow() async {
    flow = await _repository.getAcquisitionFlow(locale);
    return flow;
  }

  AcquisitionFlow getAcquisitionFlow() => flow;

  Future<AcquisitionFlow> doAction(BdcBottomButtonAction action, Map<String, String> params) {
    return _repository.doAction(action, params);
  }

}
