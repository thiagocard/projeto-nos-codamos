import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nos_codamos/data/model/header.dart';
import 'package:nos_codamos/domain/mapper/header_mapper.dart';

void main() {
  testWidgets('Should map the BdcHeader to a Header with success',
      (WidgetTester tester) async {
    final title = 'teste';
    final subtitle = 'teste 2';
    BdcHeader bdcHeader = BdcHeader(
      title: title,
      subtitle: subtitle,
    );

    var header = HeaderWidgetMapper.map(bdcHeader);

    await tester.pumpWidget(
      // Wrap header with directionality Widget to avoid errors
      Directionality(textDirection: TextDirection.ltr, child: header)
    );

    expect(find.text(title), findsOneWidget);
    expect(find.text(subtitle), findsOneWidget);
  });
}
