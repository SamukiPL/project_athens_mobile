import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/athens_core/presentation/button_loader/button_loader.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/base_registration_form_step.dart';
import 'package:project_athens/more_flow/screens/delete_account/delete_account_bloc.dart';
import 'package:provider/provider.dart';

class DeleteAccountScreen extends BaseScreen<DeleteAccountBloc> {

  @override
  bool get showBackArrow => true;

  @override
  bool get shouldShowBottomBar => false;

  String getAppBarTitle(AppLocalizations localizations, DeleteAccountBloc bloc) {
    return localizations.getText().moreDeleteAccountTitle();
  }

  @override
  Widget buildBody(BuildContext context, DeleteAccountBloc bloc) {
    var localization = Provider.of<AppLocalizations>(context);

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              width: double.infinity,
              color: Theme.of(context).primaryColor,
              child: Image.asset(
                "resources/images/logo_white.png",
                height: 150,
                alignment: Alignment.center,
              ),
            ),
          // ),
          Expanded(
            child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Form(
                          key: bloc.questionnaireForm,
                          child: _buildFormControls(context, localization, bloc)
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          localization.getText().moreDeleteAccountAfterSuccessfulRequest(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Spacer(),
                    ],
                  ),
                )
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonLoader(
                  bloc.deleteAccountButtonLoadingBloc,
                  handleError: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  mainPadding: EdgeInsets.all(16),
                  actionStateWidget: Container(
                    child: Text(
                      localization.getText().moreDeleteAccountTitle(),
                      style: TextStyle(color: Colors.white),
                      textScaleFactor: 1.5,
                    ),
                  ),
                  callback: () => bloc(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFormControls(BuildContext context, AppLocalizations l10n, DeleteAccountBloc bloc) {
    return Container(
      child: Column(
        children: [
          Text(
            l10n.getText().moreDeleteAccountContent(),
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),
          ),
          Row(
            children: [
              Flexible(
                child: CheckboxFormField(
                  title: Text(l10n.getText().moreDeleteAccountReasonsAppHasErrors()),
                  onChanged: (bool newValue) {
                    bloc.applicationIsSlow = newValue;
                  },
                  validator: (flag) {
                    if (!bloc.isAnySelected) return l10n.getText().moreDeleteAccountAtLeastOneReasonRequired();

                    return null;
                  },
                  // value: false
                ),
              )
            ],
          ),
          Row(
            children: [
              Flexible(
                child: CheckboxFormField(
                  title: Text(l10n.getText().moreDeleteAccountReasonsSlowApp()),
                  onChanged: (bool newValue) {
                    bloc.notInterested = newValue;
                  },
                  validator: (flag) {
                    if (!bloc.isAnySelected) return l10n.getText().moreDeleteAccountAtLeastOneReasonRequired();

                    return null;
                  },
                  // value: false
                ),
              )
            ],
          ),
          Row(
            children: [
              Flexible(
                child: CheckboxFormField(
                  title: Text(l10n.getText().moreDeleteAccountReasonsDoNotLikeApp()),
                  onChanged: (bool newValue) {
                    bloc.manyErrors = newValue;
                  },
                  validator: (flag) {
                    if (!bloc.isAnySelected) return l10n.getText().moreDeleteAccountAtLeastOneReasonRequired();

                    return null;
                  },
                  // value: false
                ),
              )
            ],
          ),
          Row(
            children: [
              Flexible(
                child: CheckboxFormField(
                  title: Text(l10n.getText().moreDeleteAccountReasonsNotInterested()),
                  onChanged: (bool newValue) {
                    bloc.dontLikeApp = newValue;
                  },
                  validator: (flag) {
                    if (!bloc.isAnySelected) return l10n.getText().moreDeleteAccountAtLeastOneReasonRequired();

                    return null;
                  },
                  // value: false
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(child:
                TextFormField(
                  decoration: InputDecoration(
                      labelText: l10n.getText().moreDeleteAccountReasonsOtherReason(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                  onChanged: (String? newValue) {
                    bloc.anotherReasonValue = newValue;
                  },
                )
              )
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 16),
            child: Row(
              children: [
                Expanded(child:
                TextFormField(
                  decoration: InputDecoration(
                      labelText: l10n.getText().moreDeleteAccountAdditionalNotes(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                  onChanged: (String? newValue) {
                    bloc.additionalNotes = newValue;
                  },
                )
                )
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  Flexible(
                      child: CheckboxFormField(
                        title: Text(l10n.getText().moreDeleteAccountConfirmDeleteAccount()),
                        onChanged: (bool newValue) {
                          bloc.confirmDelete = newValue;
                        },
                        validator: (bool? flagValue) {
                          if (flagValue == false) {
                            return l10n.getText().moreDeleteAccountYouHaveToConfirm();
                          }

                          return null;
                        },
                        // value: false,
                      )
                  )
                ],
              )
          ),
        ],
      ),
    );
  }

  @override
  Widget? buildFloatingActionButton(BuildContext context, DeleteAccountBloc bloc) {
    return null;
  }
}
