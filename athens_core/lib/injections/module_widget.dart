import 'package:athens_core/injections/module.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ModuleWidget extends StatelessWidget {
  final List<Module> providers;

  final Widget child;

  const ModuleWidget({Key key, @required this.providers, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers.map((module) => module.getProviders()).expand((p) => p).toList(),
      child: child,
    );
  }

}
