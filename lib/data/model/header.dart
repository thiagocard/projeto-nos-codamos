import 'package:nos_codamos/data/model/bdc_component.dart';

class BdcHeader extends BdcComponent {
  final String title;
  final String subtitle;

  BdcHeader({this.title, this.subtitle}) : super('Header');
}