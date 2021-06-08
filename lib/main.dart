import 'package:flutter/material.dart';
import 'package:nos_codamos/data/repository/acquisition_repository.dart';
import 'package:nos_codamos/ui/country_selection.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

import 'data/remote/acquisition_api.dart';

void main() {
  runApp(
    Provider(
      create: (context) => AppProvider(),
      child: MyApp(),
    ),
  );
}

class AppProvider extends FutureProvider {
  final AcquisitionRepositoryImpl repository =
      AcquisitionRepositoryImpl(AcquisitionApi());
  final Map<String, String> params = {};
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => _SplashScreen(),
      },
    );
  }
}

class _SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<_SplashScreen> {
  Future<Widget> loadFromFuture() async {
    String locale = "br";
    await Provider.of<AppProvider>(context).repository.postCountry(locale);
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
