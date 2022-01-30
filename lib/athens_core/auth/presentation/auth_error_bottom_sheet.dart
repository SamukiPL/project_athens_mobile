import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/navigation/app_navigation.dart';
import 'package:provider/provider.dart';

void showAuthErrorBottomSheet(BuildContext parentContext) {
  showModalBottomSheet(
      context: parentContext,
      builder: (childContext) => _AuthErrorBottomSheet(),
      enableDrag: false,
      isDismissible: false);
}

class _AuthErrorBottomSheet extends StatelessWidget {
  const _AuthErrorBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 8, top: 32),
                child: Icon(Icons.sentiment_dissatisfied, size: 100, color: theme.primaryColor,),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 8, top: 8),
                child: Text(
                  "Coś poszło nie tak i Twoja sesja wygasła!\nZaloguj się ponownie.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              MaterialButton(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Przejdź do logowania",
                    style: TextStyle(color: Colors.white),
                    textScaleFactor: 1.5,
                  ),
                ),
                onPressed: (() {
                  final appNavigation = Provider.of<AppNavigation>(context, listen: false);
                  appNavigation.goToLoginWidget(context);
                }),
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              )
            ],
          )),
    );
  }
}
