import 'package:flutter/material.dart';
import 'package:nos_codamos/domain/model/acquisition_flow_model.dart';
import 'package:nos_codamos/ui/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AcquisitionFlowModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => AppSplashScreen(),
      },
    );
  }
}
