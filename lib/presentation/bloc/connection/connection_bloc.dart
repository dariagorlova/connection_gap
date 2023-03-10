import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'connection_event.dart';
import 'connection_state.dart';

// bloc ver. 6.
/*class ConnectionBloc extends Bloc<ConnectionEvent, InternetConnectionState> {
  final Connectivity _connectivity; // better use abstraction instead of direct usage
  ConnectionBloc(this._connectivity) : super(ConnectionInitial());

  @override
  Stream<InternetConnectionState> mapEventToState(ConnectionEvent event) async* {
    if (event is ConnectionWatchdogEvent){
      _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
        if (result == ConnectivityResult.none) {
          add(ConnectionNotifyEvent());
        } else {
          add(ConnectionNotifyEvent(isConnected: true));
        }
      });
    }
    else if (event is ConnectionNotifyEvent){
      if (event.isConnected) {
        yield ConnectionSuccess();
      } else {
        yield ConnectionError();
      }
    }
  }
}*/

class ConnectionBloc extends Bloc<ConnectionEvent, InternetConnectionState> {
  final Connectivity _connectivity; // better use abstraction instead of direct usage
  ConnectionBloc(this._connectivity) : super(ConnectionInitial()) {
    on<ConnectionWatchdogEvent>(_observe);
    on<ConnectionNotifyEvent>(_notifyStatus);
  }

  void _observe(event, emit) {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) async {
      // iOS emulator
      final res = await Future.delayed(const Duration(seconds: 2)).then((value) => _ping());
      add(ConnectionNotifyEvent(isConnected: res));

      // real devices, Android emulator
      // switch (result) {
      //   case ConnectivityResult.wifi:
      //   case ConnectivityResult.mobile:
      //     final res = await Future.delayed(const Duration(seconds: 5)).then((value) => _ping());
      //     add(ConnectionNotifyEvent(isConnected: res));
      //     break;

      //   default:
      //     // no inetrnet connection
      //     add(ConnectionNotifyEvent());
      //     break;
      // }
    });
  }

  Future<bool> _ping() async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    return isOnline;
  }

  void _notifyStatus(ConnectionNotifyEvent event, emit) {
    event.isConnected ? emit(ConnectionSuccess()) : emit(ConnectionError());
  }
}
