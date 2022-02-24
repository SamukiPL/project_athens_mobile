import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

T providerWithDefault<T>(BuildContext context, T defaultValue,
    {bool listen = true}) {
  try {
    return Provider.of<T>(context, listen: listen);
  } catch (e) {
    return defaultValue;
  }
}
