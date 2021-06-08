class AcquisitionFlow {
  final List<BdcPage> pages;

  AcquisitionFlow(this.pages);
}

/// Tela do do fluxo
class BdcPage {
  final List<BdcComponent> children;

  BdcPage(this.children);
}

abstract class BdcComponent {

  static const header = 'Header';
  static const input = 'Input';
  static const bottomButton = 'BottomButton';

  String type;

  BdcComponent(this.type);
}
