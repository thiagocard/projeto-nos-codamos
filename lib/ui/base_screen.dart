import 'package:flutter/material.dart';
import 'package:nos_codamos/data/model/acquisition_flow.dart';
import 'package:nos_codamos/data/model/input.dart';
import 'package:nos_codamos/main.dart';
import 'package:nos_codamos/ui/widget/bottom_button_mapper.dart';
import 'package:nos_codamos/ui/widget/header_mapper.dart';
import 'package:nos_codamos/ui/widget/input_mapper.dart';
import 'package:nuds_mobile/nuds_mobile.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatefulWidget {
  final int _index;

  BaseScreen([this._index]);

  @override
  State<StatefulWidget> createState() => BaseScreenState(_index);
}

class BaseScreenState extends State<BaseScreen> {
  final int _index;
  BdcPage page;
  Map<String, TextEditingController> _controllers = {};

  BaseScreenState(this._index);

  @override
  void initState() {
    super.initState();
    page = Provider.of<AppProvider>(context, listen: false)
        .repository
        .acquisitionFlow
        .pages[_index];
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      // top: TopBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      // ),
      body: Column(
        children: _render(context),
      ),
      bottom: _renderBottom(),
    );
  }

  Widget _renderBottom() {
    return BottomButtonWidgetMapper.map(
        page.bottom,
        (page.children
                    .whereType<BdcInputComponent>()
                    .where(
                        (element) => _controllers[element.id].value.text == "")
                    .toList()
                    .length >
                0
            ? null // Check elements
            : page.bottom.action != null
                ? () {
                    _saveParams();
                    var provider =
                        Provider.of<AppProvider>(context, listen: false);
                    provider.repository
                        .doAction(page.bottom.action, provider.params);
                  }
                : () {
                    _saveParams();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BaseScreen(_index + 1)));
                  }));
  }

  _saveParams() {
    page.children.forEach((child) {
      if (child is BdcInputComponent) {
        Provider.of<AppProvider>(context, listen: false).params[child.id] =
            _controllers[child.id].value.text;
      }
    });
  }

  List<Widget> _render(BuildContext context) {
    return page.children.map((child) {
      switch (child.type) {
        case BdcComponent.header:
          return HeaderWidgetMapper.map(child);
        case BdcComponent.input:
          var id = (child as BdcInputComponent).id;
          if (_controllers[id] == null) {
            _controllers[id] = TextEditingController();
            _controllers[id].addListener(() {
              setState(() {});
            });
          }
          return InputWidgetMapper.map(child, _controllers[id]);
        default:
          return null;
      }
    }).toList();
  }
}
