import 'package:nos_codamos/data/model/bottom_button.dart';

class AcquisitionFlow {
  final List<BdcPage> pages;

  AcquisitionFlow(this.pages);
}

/// Tela do do fluxo
class BdcPage {
  final List<BdcComponent> children;
  final BdcBottomButton bottom;

  BdcPage(this.children, this.bottom);
}

abstract class BdcInputComponent extends BdcComponent {
  String id;
  String type;

  BdcInputComponent(this.id, this.type) : super(type);
}

abstract class BdcComponent {
  static const header = 'Header';
  static const input = 'Input';
  static const bottomButton = 'BottomButton';
  static const image = 'Image';

  String type;

  BdcComponent(this.type);
}
