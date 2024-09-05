import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:disease_detector_app/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as developer;

class NetworkProvider extends ChangeNotifier {
  List<ConnectivityResult> connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;

  bool isOnline = false;

  void updateStatus() {
    connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    notifyListeners();
  }

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    connectionStatus = result;

    if (connectionStatus.contains(ConnectivityResult.none)) {
      isOnline = false;
      showMessage('No internet connection');
    } else {
      isOnline = true;
    }
    notifyListeners();
  }
}
