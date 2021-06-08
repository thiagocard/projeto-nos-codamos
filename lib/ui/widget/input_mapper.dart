import 'package:nos_codamos/data/model/input.dart';
import 'package:nuds_mobile/nuds_mobile.dart';

class InputWidgetMapper {
  InputWidgetMapper._();

  static InputText map(BdcInput bdcInput) {
    return InputText(
      placeholder: bdcInput.placeholder,
    );
  }
}
