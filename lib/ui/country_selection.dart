import 'package:flutter/material.dart';
import 'package:nos_codamos/data/model/acquisition_flow.dart';
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

  BaseScreenState(this._index);

  @override
  void initState() {
    super.initState();
    page = Provider.of<AppProvider>(context)
        .repository
        .acquisitionFlow
        .pages[_index];
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      top: TopBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Spacings.x4, vertical: Spacings.x2),
            child: _render(context),
          )
        ],
      ),
      bottom: _renderBottom(),
    );
  }

  Widget _renderBottom() => BottomButtonWidgetMapper.map(page.bottom, () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BaseScreen(_index + 1)));
    });

  Widget _render(BuildContext context) {
    page.children.map((child) {
      switch (child.type) {
        case BdcComponent.header:
          return HeaderWidgetMapper.map(child);
        case BdcComponent.input:
          return InputWidgetMapper.map(child);
      }
    });
  }
}
