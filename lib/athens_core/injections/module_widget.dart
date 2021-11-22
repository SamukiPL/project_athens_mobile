import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:provider/provider.dart';

class ModuleWidget extends StatefulWidget {
  late final List<Module> providers;

  late final Widget child;

  ModuleWidget({Key? key, required this.providers, required this.child})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      ModulesState(providers: providers, child: child);
}

class ModulesState extends State<ModuleWidget> {
  bool initialized;
  late final List<Module> providers;

  late final Widget child;

  ModulesState({required this.providers, required this.child, this.initialized = true});

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return MultiProvider(
        providers: providers.expand((p) => p.getProviders()).toList(),
        child: child,
      );
    }
    return Container();
  }

  @override
  void dispose() {
    providers.forEach((module) {
      module.dispose();
    });
    super.dispose();
  }
}
