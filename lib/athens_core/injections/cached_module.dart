import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/injections/module.dart';

abstract class CachedModule extends Module {

  CachedModule(BuildContext context): super(context);

  void disposeCache();

}