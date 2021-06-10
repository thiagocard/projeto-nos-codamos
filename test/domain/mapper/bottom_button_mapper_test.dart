import 'package:flutter_test/flutter_test.dart';
import 'package:nos_codamos/data/model/bottom_button.dart';
import 'package:nos_codamos/domain/mapper/bottom_button_mapper.dart';

void main() {
  testWidgets('Should map the BdcBottomButton to a BottomBar with success', (WidgetTester tester) async {
    final text = 'teste';
    BdcBottomButton bdcBottomButton = BdcBottomButton(
        text: text,
        style: 'no_style',
        action:
            BdcBottomButtonAction(method: 'post', uri: '/submit', steps: []));

    var bottomBar = BottomButtonWidgetMapper.map(bdcBottomButton, () {});

    await tester.pumpWidget(bottomBar);

    expect(find.text(text), findsOneWidget);
  });
}
