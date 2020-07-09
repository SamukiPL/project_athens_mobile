import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/main/firebase/firebase_messages.dart';
import 'package:provider/provider.dart';

class FirebaseMessagingModule extends Module {

  final FirebaseMessages _firebaseMessages;

  FirebaseMessagingModule(BuildContext context, this._firebaseMessages) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    return [
      Provider<FirebaseMessages>.value(
        value: _firebaseMessages,
      )
    ];
  }

}