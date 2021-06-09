import 'package:flutter/material.dart';
import 'package:nos_codamos/domain/model/acquisition_flow_model.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

import 'base_screen.dart';

class AppSplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen> {
  Future<Widget> loadFromFuture() async {
    final provider = Provider.of<AcquisitionFlowModel>(context, listen: false);
    provider.locale = 'br'; // Platform.localeName.substring(Platform.localeName.indexOf('_') + 1);;
    debugPrint('locale = ${provider.locale}');
    await provider.fetchAcquisitionFlow();
    return Future.value(new BaseScreen(0));
  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        navigateAfterFuture: loadFromFuture(),
        title: new Text(
          'Welcome In SplashScreen',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        image: new Image.network('https://i.imgur.com/TyCSG9A.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: () => print("Flutter Egypt"),
        loaderColor: Colors.red);
  }
}
