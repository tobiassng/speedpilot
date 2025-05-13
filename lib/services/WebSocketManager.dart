import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketManager {
  static final WebSocketManager _instance = WebSocketManager._internal();

  factory WebSocketManager() {
    return _instance;
  }

  WebSocketManager._internal();

  WebSocketChannel? _channel;
  StreamSubscription? _subscription;

  double _currentSpeed = 0.0;
  double _currentAngle = 0.0;

  Future<void> connect(String url) async {
    final uri = Uri.parse(url);
    _channel = WebSocketChannel.connect(uri);
  }

  void sendMessage(String message) {
    _channel?.sink.add(message);
    print("Nachricht gesendet: $message");
  }

  void _sendDrivingCommand() {
    final Map<String, dynamic> jsonData = {
      "command": "move",
      "speed": _currentSpeed,
      "angle": _currentAngle
    };
    final String jsonString = jsonEncode(jsonData);
    sendMessage(jsonString);
  }

  void updateSpeed(double speed) {
    _currentSpeed = speed;
    _sendDrivingCommand();
  }

  void updateAngle(double angle) {
    _currentAngle = angle;
    _sendDrivingCommand();
  }

  void receiveMessage(void Function(dynamic message) onMessage) {
    _subscription = _channel?.stream.listen(
      (message) {
        onMessage(message);
      },
      onError: (error) {
        print("Fehler beim Empfangen: $error");
      },
      onDone: () {
        print("WebSocket-Verbindung beendet");
      },
      cancelOnError: true,
    );
  }

  void closeConnection() {
    _subscription?.cancel();
    _channel?.sink.close();
    print("WebSocket-Verbindung geschlossen");
  }
}