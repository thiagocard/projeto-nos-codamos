import 'acquisition_flow.dart';

class BdcBottomButton extends BdcComponent {
  final String text;
  final String style;
  final BdcBottomButtonAction action;

  BdcBottomButton({this.text, this.style, this.action})
      : super(BdcComponent.bottomButton);

}

class BdcBottomButtonAction {
  final String method;
  final String uri;
  final List<String> steps;

  BdcBottomButtonAction({this.method, this.uri, this.steps});
}
