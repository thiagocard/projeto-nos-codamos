import 'acquisition_flow.dart';

class BdcInput extends BdcInputComponent {
  static const keyobardNumber = 'number';
  static const keyobardDateTime = 'datetime';
  static const keyobardEmail = 'email';
  static const keyobardString = 'string';

  final String id;
  final String keyboard;
  final String format;

  BdcInput({this.id, this.keyboard, this.format})
      : super(id, BdcComponent.input);
}
