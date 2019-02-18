import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';

/*
    Coordinator's module used by ViewModels to check for internet connection availability.
    usage : Subscribe to the stream exposed by "connectionChangeController"
*/
abstract class IConnectivity {
  Stream  connectionChangeStream();
  void    initializeConnectivityModule();
}

class ConnectivityModule implements IConnectivity {
  static final ConnectivityModule  _instance = ConnectivityModule._internal();
  factory ConnectivityModule() {
    return  _instance;
  }
  ConnectivityModule._internal();

  bool _hasConnection;
  final StreamController connectionChangeController = new StreamController.broadcast();
  final Connectivity _connectivity = Connectivity();

  void _initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }

  void dispose() {
    connectionChangeController.close();
  }

  void _connectionChange(ConnectivityResult result) {
    checkConnection();
  }

  Future<bool> checkConnection() async {
    bool previousConnection = _hasConnection;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _hasConnection = true;
      } else {
        _hasConnection = false;
      }
    } on SocketException catch(_) {
      _hasConnection = false;
    }
    //The connection status changed send out an update to all listeners
    if (previousConnection != _hasConnection) {
      connectionChangeController.add(_hasConnection);
    }
    return _hasConnection;
  }

  @override
  Stream connectionChangeStream() {
    return connectionChangeController.stream;
  }

  @override
  void initializeConnectivityModule() {
    this._initialize();
  }
}