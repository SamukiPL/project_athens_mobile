import 'package:flutter/src/widgets/framework.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/db/athens_db.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:provider/provider.dart';

class DatabaseModule extends Module {
  DatabaseModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    return [
      Provider(
        create: (_) => AthensDatabase()
      )
    ];
  }
}
