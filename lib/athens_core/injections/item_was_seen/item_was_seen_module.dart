import 'package:flutter/src/widgets/framework.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/chopper/authenticated_dio_client.dart';
import 'package:project_athens/athens_core/data/item_was_seen/network/seen_item_api.dart';
import 'package:project_athens/athens_core/data/item_was_seen/seen_item_data_source.dart';
import 'package:project_athens/athens_core/db/athens_db.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:provider/provider.dart';

class ItemWasSeenModule extends Module {
  ItemWasSeenModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final AuthenticatedDioClient dio =
        Provider.of<AuthenticatedDioClient>(context);
    final database = Provider.of<AthensDatabase>(context);

    final api = SeenItemApi(dio.client);
    return [Provider(create: (_) => SeenItemDataSource(api, database))];
  }
}
