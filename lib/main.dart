import 'package:flutter/material.dart';
import 'package:nos_codamos/ui/country_selection.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => BaseScreen(),
      },
    );
  }
}
