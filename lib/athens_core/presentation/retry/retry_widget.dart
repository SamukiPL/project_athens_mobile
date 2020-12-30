import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/widget_state.dart';
import 'package:provider/provider.dart';

class RetryWidget extends StatelessWidget {

  final ErrorType errorType;
  final VoidCallback onRetry;

  final String networkErrorText;
  final String serverErrorText;

  final TextAlign textAlign;
  final Color color;

  const RetryWidget(
      {Key key,
        @required this.errorType,
        @required this.onRetry,
        this.networkErrorText,
        this.serverErrorText,
        this.textAlign = TextAlign.center,
        this.color = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = Provider.of<AppLocalizations>(context);

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.sentiment_dissatisfied, size: 50, color: this.color,),
          Text(_getCorrectErrorText(localization), textAlign: this.textAlign, style: TextStyle(color: this.color)),
          MaterialButton(
            child: Text(
              localization.getText().universalRetry(),
              style: TextStyle(color: this.color),
            ),
            onPressed: onRetry
          )
        ],
      ),
    );
  }

  String _getCorrectErrorText(AppLocalizations localization) {
    String errorText;
    switch(errorType) {
      case ErrorType.NETWORK:
        errorText = networkErrorText ?? localization.getText().universalErrorNetwork();
        break;
      case ErrorType.SERVER:
        errorText = serverErrorText ?? localization.getText().universalErrorServer();
        break;
      case ErrorType.UNKNOWN:
        errorText = localization.getText().universalErrorUnknown();
        break;
    }
    return errorText;
  }

}