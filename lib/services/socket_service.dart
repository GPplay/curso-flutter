import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  connecting,
  connected,
  disconnected,
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  late IO.Socket _socket;

  SocketService() {
    _initConfig();
  }

  ServerStatus get serverStatus => _serverStatus;

  void _initConfig() {
    _socket = IO.io('http://localhost:3000', {
      'transports': ['websocket'],
      'autoConnect': true,
    });

    _socket.onConnect((_) {
      debugPrint('Connected');
      _serverStatus = ServerStatus.connected;
      notifyListeners();
    });

    _socket.onDisconnect((_) {
      debugPrint('Disconnected');
      _serverStatus = ServerStatus.disconnected;
      notifyListeners();
    });
  }
}