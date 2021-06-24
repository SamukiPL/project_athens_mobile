import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/auth/auth_repository_impl.dart';
import 'package:project_athens/athens_core/auth/network/auth_api.dart';
import 'package:project_athens/athens_core/auto_updater/auto_updater.dart';
import 'package:project_athens/athens_core/auto_updater/auto_updater_module.dart';
import 'package:project_athens/athens_core/chopper/auth_facade.dart';
import 'package:project_athens/athens_core/chopper/auth_interceptor.dart';
import 'package:project_athens/athens_core/chopper/error_interceptor.dart';
import 'package:project_athens/athens_core/chopper/network_module.dart';
import 'package:project_athens/athens_core/i18n/localization_module.dart';
import 'package:project_athens/athens_core/injections/module_widget.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_navigator.dart';
import 'package:project_athens/athens_core/utils/firebase/firebase_deputy_subscriber.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/cache/subscribed_deputies_cache.dart';
import 'package:project_athens/deputies_utils/data/firebase_deputies_repository_impl.dart';
import 'package:project_athens/deputies_utils/data/network/deputies_api.dart';
import 'package:project_athens/deputies_utils/domain/firebase_deputies/firebase_deputies_use_case.dart';
import 'package:project_athens/deputies_utils/injections/subscribed_deputy_cache_module.dart';
import 'package:project_athens/main/firebase/firebase_messages.dart';
import 'package:project_athens/main/injections/wakelock_module.dart';
import 'package:project_athens/main/wakelock/wakelock_service.dart';
import 'package:provider/provider.dart';

class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseMessages = Provider.of<FirebaseMessages>(context);

    return ModuleWidget(
      providers: [
        NetworkModule(context),
        LocalizationModule(context),
        SubscribedDeputyCacheModule(context, firebaseMessages),
        WakelockModule(context),
        AutoUpdaterModule(context)
      ],
      child: Consumer<BottomNavigationBloc>(
        builder: (context, bloc, child) => WillPopScope(child: child, onWillPop: () async {
          bloc.pop();
          return false;
        }),
        child: Stack(
          children: BottomNavItem.values
              .map((item) =>
                  DestinationNavigator(item, item.getInitialDestination()))
              .toList(),
        ),
      ),
    );
  }
}
