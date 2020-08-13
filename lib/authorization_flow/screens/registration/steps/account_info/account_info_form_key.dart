import 'package:flutter/cupertino.dart';

class AccountInfoFormKey {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

}