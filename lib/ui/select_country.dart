import 'package:flutter/material.dart';
import 'package:nos_codamos/data/model/welcome.dart';
import 'package:nos_codamos/domain/model/acquisition_flow_model.dart';
import 'package:nos_codamos/ui/base_screen.dart';
import 'package:nuds_mobile/nuds_mobile.dart';
import 'package:provider/provider.dart';

class SelectCountry extends StatefulWidget {
  WelcomeData welcomeData;
  String startDefaultCountry;

  SelectCountry(this.welcomeData, this.startDefaultCountry);

  @override
  _SelectCountryState createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  var countries = [];

  int _favourite = -1;
  String _defaultCountry = "br";
  String _textDefaultCountry = "Brasil";
  bool _loading = false;
  AcquisitionFlowModel _provider;

  @override
  void initState() {
    super.initState();
    countries = widget.welcomeData.content["countries"];
    _provider = Provider.of<AcquisitionFlowModel>(context, listen: false);
    countries.forEach((e) {
      if (e["value"] == widget.startDefaultCountry) {
        setState(() {
          _defaultCountry = e["value"];
          _textDefaultCountry = e["text"];
          _provider.locale = e["value"];
        });
      }
    });
  }

  _navigateToForm(BuildContext context) {
    final route = TakeoverRoute(builder : (_) => BaseScreen(0));
    Navigator.of(context).push(route);
  }

  _openModal() {
    presentBottomSheetPromptModal(
        context: context,
        scrollBuilder: (ctx, controller) {
          return InputScreenModalSelectionList(
            controller: controller,
            title: Text(widget.welcomeData.content[_defaultCountry]["select"]),
            itemCount: countries.length,
            itemBuilder: (context, refresh, index) {
              return RadioListRow<int>(
                primary: Text(countries[index]["text"]),
                groupValue: _favourite,
                value: index,
                onChanged: (selectedItemIndex) {
                  setState(() {
                    _favourite = selectedItemIndex;
                    _defaultCountry = countries[selectedItemIndex]["value"];
                    _textDefaultCountry = countries[selectedItemIndex]["text"];
                    _provider.locale = _defaultCountry;
                  });
                  // call this function to propagate state changes
                  // to the bottom sheet screen
                  refresh();
                  Navigator.of(context).pop();
                },
                // NuDS recommends no decoration when opening
                // a list on a modal
                style: const ListRowStyle.noBorder(),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      body: SingleChildScrollView(
        child: Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Button(
                      type: ButtonType.ghost,
                      onPressed: _openModal,
                      trailingIcon: Icon(NuDSIcons.expand_more),
                      child: Text(_textDefaultCountry),
                    )
                  ],
                ),
                Header(
                  title: Text(widget.welcomeData.content[_defaultCountry]["welcome"]),
                ),
                // Image.asset('assets/creditcard.jpg'),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: Spacings.x24),
                    child: Image(
                        image: NuDSImages.pf_darkbg_horizontal_floating_card
                    ),
                ),
              ],
            )),
      ) ,
      bottom: BottomBar(
        primary: BottomBarAction(
          child: Text(widget.welcomeData.content[_defaultCountry]["start"]),
          type: ButtonType.primary,
          loading: _loading,
          onPressed: !_loading ? () async {
            setState(() {
              _loading =  true;
            });
            await _provider.fetchAcquisitionFlow();
            setState(() {
              _loading = false;
            });
            _navigateToForm(context);
          } : null,
        ),
      ),
    );
  }
}
