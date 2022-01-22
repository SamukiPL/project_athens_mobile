import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/auth/auth_storage.dart';
import 'package:project_athens/athens_core/auth/storage/tokens.dart';
import 'package:project_athens/athens_core/chopper/jwt_decode.dart';
import 'package:project_athens/athens_core/presentation/grid/tiles/simple_tile/simple_tile.dart';
import 'package:project_athens/athens_core/presentation/grid/tiles/simple_tile/simple_tile_bloc.dart';
import 'package:provider/provider.dart';

class UserNameTile extends SimpleTile {
  UserNameTile() : super(text: "",
      textStyle: TextStyle(
        color: Colors.black87,
        fontSize: 25
      ),
      elevation: 0,
      key: Key('tile_username'), bloc: SimpleTileBloc()
  );

  @override
  Widget build(BuildContext context) {
    return super.buildTile(
        context: context,
        tile: FutureProvider<String?>.value(
          initialData: null,
          value: getUserName(),
          child: Consumer<String?>(
            builder: (context, text, _) => text == null
                ? super.buildLoader()
                : super.buildTextAndIcon(text: "Witaj, " + text, crossAxisAlignment: CrossAxisAlignment.start)
            )
          ),
    );
  }

  Future<String> getUserName() async {
    final AuthStorage storage = AuthStorage();

    final Tokens tokens = await storage.provideTokens();

    Map<String, dynamic> decodedToken = Jwt().parseJwt(tokens.accessToken);

    String userName = '';

    if (decodedToken.containsKey('firstName') && decodedToken['firstName'] != null && decodedToken['firstName'] != "") {
      userName = decodedToken['firstName'];

      if (decodedToken.containsKey('lastName') && decodedToken['lastName'] != null && decodedToken['lastName'] != "") {
        userName = userName + ' ' + decodedToken['lastName'];
      }
    } else {
      userName = decodedToken['login'];
    }

    return userName;
  }
}