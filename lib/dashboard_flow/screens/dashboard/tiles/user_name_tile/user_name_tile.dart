import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/presentation/grid/tiles/simple_tile/simple_tile.dart';
import 'package:provider/provider.dart';

import '../../../../../athens_core/auth/auth_storage.dart';

class UserNameTile extends SimpleTile {
  UserNameTile() : super(text: "", textStyle: TextStyle(color: Colors.black87, fontSize: 25, ), elevation: 0);

  @override
  Widget build(BuildContext context) {
    final authStorage = AuthStorage();

    return super.buildTile(
        context: context,
        boxDecoration: BoxDecoration(),
        tile: FutureProvider<String?>.value(
          initialData: null,
          value: authStorage.getUserName(),
          child: Consumer<String?>(
            builder: (context, text, _) => text == null
                ? super.buildLoader()
                : super.buildTextAndIcon(text: "Witaj, " + text, crossAxisAlignment: CrossAxisAlignment.start)
            )
          ),
    );
  }
}