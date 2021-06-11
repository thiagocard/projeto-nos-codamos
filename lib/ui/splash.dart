import 'package:flutter/material.dart';
import 'package:nos_codamos/data/model/welcome.dart';
import 'package:nos_codamos/domain/model/acquisition_flow_model.dart';
import 'package:nos_codamos/ui/select_country.dart';
import 'package:nuds_mobile/nuds_mobile.dart';
import 'package:provider/provider.dart';

class AppSplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen> {
  loadFromFuture() async {
    final provider = Provider.of<AcquisitionFlowModel>(context, listen: false);
    provider.locale =
        'br'; // Platform.localeName.substring(Platform.localeName.indexOf('_') + 1);;
    debugPrint('locale = ${provider.locale}');
    WelcomeData welcomeData = await provider.fetchWelcome();
    provider.welcomeData = welcomeData;
    if (welcomeData.content == null) {
      presentBottomSheetPromptModal(
        maxSize: 1,
        context: context,
        builder: (ctx) {
          return PromptModal.retrial(
            title: const Text('An error has occurred'),
            subtitle: const Text(
              'Retry request',
            ),
            retrialActionTitle: 'Retry',
            onRetrialActionTap: () {
              loadFromFuture();
            },
          );
        },
      );
      return false;
    }
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            settings: RouteSettings(name: SelectCountry.routeName),
            builder: (ctx) => SelectCountry(welcomeData, provider.locale)));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadFromFuture();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
        body:Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: NuDSImages.pf_ludic_others_highfive),
              Text(
                'Nubank Acquisition',
                style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: CircularProgressIndicator(),
              )
              ,
            ],
          ),
        ),
    );
  }
}
