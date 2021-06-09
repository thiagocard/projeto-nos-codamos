import 'acquisition_flow.dart';

class BdcInput extends BdcInputComponent {
  final String id;
  final String keyboard;
  final String format;

  BdcInput({this.id, this.keyboard, this.format}) : super(id, BdcComponent.input);

}
