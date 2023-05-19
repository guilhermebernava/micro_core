import 'package:micro_core/app/utils.dart';

abstract class MicroApp {
  String get appName;
  Map<String, WidgetBuilderArgs> get routes;
  void Function() get injectionRegister;
}
