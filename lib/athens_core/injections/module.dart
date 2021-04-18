import 'package:flutter/cupertino.dart';
import 'package:provider/single_child_widget.dart';

abstract class Module{

  final BuildContext context;

  Module(this.context);

  List<SingleChildWidget> getProviders();

}