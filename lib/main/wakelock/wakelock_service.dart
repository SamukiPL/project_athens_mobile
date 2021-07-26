import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/configuration/configuration.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/navigation/navigation_event.dart';
import 'package:wakelock/wakelock.dart';

class WakelockService {
  final Configuration _config;
  final BottomNavigationBloc _navigationBloc;

  WakelockService(this._config, this._navigationBloc) {
    _currentScreen = _navigationBloc.currentItem;
    _navigationBloc.addListener(() {
      if (_currentScreen != _navigationBloc.currentItem) {
        _currentScreen = _navigationBloc.currentItem;
        shouldLock();
      }
    });
    _config.wakelockOnTimeline.listen((event) => _handleTimelineWakelock(event));
    Wakelock.enabled.asStream().listen((event) => _isLocked = event);
  }

  // master lock is used when it comes to lock on main screens
  // e.g. timeline view
  bool _masterLock = false;
  bool _isLocked = false;
  BottomNavItem _currentScreen;

  void _handleTimelineWakelock(bool prevent) {
    _masterLock = prevent;
    shouldLock();
  }

  void shouldLock() async {
    if (_masterLock && _currentScreen == BottomNavItem.TIMELINE) {
      _enable();
    } else {
      _disable();
    }
  }

  void _enable() {
    if (!_isLocked) {
      Wakelock.enable();
    }
  }

  void _disable() {
    if (_isLocked) {
      Wakelock.disable();
    }
  }

  void tryToEnableLock() {
    _enable();
  }

  void tryToDisableLock() {
    if (!_masterLock) _disable();
  }
}