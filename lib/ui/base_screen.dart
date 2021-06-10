import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:nos_codamos/data/model/acquisition_flow.dart';
import 'package:nos_codamos/data/model/input.dart';
import 'package:nos_codamos/domain/mapper/image_mapper.dart';
import 'package:nos_codamos/domain/mapper/input_mapper.dart';
import 'package:nos_codamos/domain/model/acquisition_flow_model.dart';
import 'package:nos_codamos/domain/mapper/bottom_button_mapper.dart';
import 'package:nos_codamos/domain/mapper/header_mapper.dart';
import 'package:nuds/nuds.dart' as nuds;
import 'package:nuds_mobile/nuds_mobile.dart' as nuds_mobile;
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
    page = Provider.of<AcquisitionFlowModel>(context, listen: false)
        .getAcquisitionFlow()
        .pages[_index];
  }

  @override
  Widget build(BuildContext context) {
    return nuds_mobile.Screen(
      top: nuds_mobile.TopBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: _render(context),
      ),
      bottom: _renderBottom(context),
    );
  }

  Widget _errorScreen(BuildContext context, dynamic error, VoidCallback retry) {
    debugPrint('Erro: $error');
    return nuds.ClosureScreen.image(
      nuds_mobile.NuDSImages.rollerblader,
      appBar: nuds.TopBar(
        leadingIcon: nuds_mobile.NuDSIcons.close,
        leadingOnPressed: () => Navigator.of(context).pop(),
      ),
      title: 'Opa!',
      description: 'Deu pau!!!',
      bottom: nuds.BottomButton(
        text: 'SAIR',
        primary: true,
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Future _displayStepName() async {
    try {
      await Future.value(null);
    } catch (e) {
      /// avoiding the error screen
    }
  }

  Widget _renderBottom(BuildContext context) {
    return page.bottom != null
        ? BottomButtonWidgetMapper.map(page.bottom, _onPressButton())
        : null;
  }

  _onPressButton() {
    return (page.children
                .whereType<BdcInputComponent>()
                .where((element) => _controllers[element.id].value.text == "")
                .toList()
                .length >
            0
        ? null // Check elements
        : (page.bottom != null && page.bottom.action != null)
            ? () {
                _saveParams();
                var provider =
                    Provider.of<AcquisitionFlowModel>(context, listen: false);

                nuds_mobile.presentTransitionScreen(
                  context: context,
                  semanticsLabel: 'Creating your account, please wait',

                  /// What should happen when transitions
                  /// successfully finished
                  onTransitionEnd: () {},

                  /// callback must return an error screen (Widget)
                  /// in case a transition's computation
                  /// raises an exception
                  onErrorBuilder: (context, error, retry) =>
                      _errorScreen(context, error, retry),

                  /// Describe your transition steps here
                  steps:
                      _buildTransitionSteps(provider, page.bottom.action.steps),
                );
              }
            : () {
                _saveParams();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BaseScreen(_index + 1)));
              });
  }

  _saveParams() {
    var provider = Provider.of<AcquisitionFlowModel>(context, listen: false);
    page.children.forEach((child) {
      if (child is BdcInputComponent) {
          provider.params[child.id] = _controllers[child.id].value.text;
      }
    });
    provider.params['country-code'] = provider.locale;
  }

  List<Widget> _render(BuildContext context) {
    return page.children.map((child) {
      switch (child.type) {
        case BdcComponent.header:
          return HeaderWidgetMapper.map(child);
        case BdcComponent.image:
          return ImageWidgetMapper.map(child);
        case BdcComponent.input:
          var id = (child as BdcInputComponent).id;
          if (_controllers[id] == null) {
            BdcInput inputChild = (child as BdcInput);
            _controllers[id] = inputChild.format != null
                ? MaskedTextController(mask: inputChild.format)
                : TextEditingController();
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

  List<nuds_mobile.TransitionStep> _buildTransitionSteps(AcquisitionFlowModel provider,
      [List<String> steps]) {
    if (steps != null) {
      List<nuds_mobile.TransitionStep> transitionSteps = [];
      steps.asMap().forEach((index, step) {
        final transitionStep = nuds_mobile.TransitionStep(
          text: step,
          asyncComputation: index == steps.length - 1
              ? () async {
                  AcquisitionFlow flow = await provider.doAction(
                      page.bottom.action, provider.params);
                  Provider.of<AcquisitionFlowModel>(context, listen: false)
                      .concatPages(flow.pages);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => BaseScreen(_index + 1)));
                  return flow;
                }
              : _displayStepName,
        );
        transitionSteps.add(transitionStep);
      });

      return transitionSteps;
    } else {
      return [];
    }
  }
}
