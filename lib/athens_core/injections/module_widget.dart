import 'package:project_athens/athens_core/injections/module.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ModuleWidget extends StatelessWidget {
  late final List<Module> providers;

  late final Widget child;

  ModuleWidget({Key? key, required this.providers, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers.expand((p) => p.getProviders()).toList(),
      child: child,
    );
  }

}
