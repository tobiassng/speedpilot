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

  Future<void> connect(String url) async {
    final uri = Uri.parse(url);
    _channel = WebSocketChannel.connect(uri);
    print("WebSocket verbunden");
  }

  void sendMessage(String message) {
    _channel?.sink.add(message);
    print("Nachricht gesendet: $message");
  }

  void sendDrivingData(String command, double speed, double angle) {
    final Map<String, dynamic> jsonData = {
      "command": command,
      "speed": speed,
      "angle": angle
    };
    final String jsonString = jsonEncode(jsonData);
    sendMessage(jsonString);
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