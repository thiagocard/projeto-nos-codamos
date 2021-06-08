import 'package:flutter/material.dart';
import 'package:nuds_mobile/nuds_mobile.dart';

class BaseScreen extends StatelessWidget {

  const BaseScreen({Key key}) : super(key: key);

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
            padding:
                const EdgeInsets.symmetric(horizontal: Spacings.x4, vertical: Spacings.x2),
            child: _render(),
          )
        ],
      ),
    );
  }

  Widget _render() {
    return Column(
      children: [
        Header()
      ],
    );
  }
}
