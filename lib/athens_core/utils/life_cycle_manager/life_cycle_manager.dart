import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/utils/life_cycle_manager/life_cycle_service.dart';
import 'package:project_athens/athens_core/utils/notifications_service.dart';

class LifeCycleManager extends StatefulWidget {
  LifeCycleManager({Key? key, required this.child, required this.lifeCycle}) : super(key: key);

  final Widget child;
  final LifeCycleService lifeCycle;

  @override
  _LifeCycleManagerState createState() => _LifeCycleManagerState();
}

class _LifeCycleManagerState extends State<LifeCycleManager> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('AppLifecycleState: $state');

    if (state == AppLifecycleState.resumed) {
      widget.lifeCycle.applicationResumed();
      NotificationsService.instance?.onApplicationResumed();
    }

    if (state == AppLifecycleState.paused) {
      widget.lifeCycle.paused();
    }

    if (state == AppLifecycleState.inactive) {
      widget.lifeCycle.inactive();
    }

    if (state == AppLifecycleState.detached) {
      widget.lifeCycle.detached();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }
}