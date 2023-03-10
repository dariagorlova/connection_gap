abstract class ConnectionEvent {}

class ConnectionWatchdogEvent extends ConnectionEvent {}

class ConnectionNotifyEvent extends ConnectionEvent {
  final bool isConnected;

  ConnectionNotifyEvent({this.isConnected = false});
}
