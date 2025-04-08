import 'dart:io';
import 'dart:convert';

class WebSocketManager {
  static final WebSocketManager _instance = WebSocketManager._internal();
  late WebSocket _webSocket;

  factory WebSocketManager() {
    return _instance;
  }

  WebSocketManager._internal();

  Future<void> connect(String url) async {
    _webSocket = await WebSocket.connect(url);
    print("WebSocket verbunden");
  }

  WebSocket get connection => _webSocket;

  void sendMessage(String message) {
    _webSocket.add(message);
    print("Nachricht gesendet: $message");
  }
  void listenSpeed(dynamic speed) {
    _webSocket.listen(speed);
    print("Nachricht empfangen: $speed");
  }
  void closeConnection() {
    _webSocket.close();
    print("WebSocket-Verbindung geschlossen");
  }
  void sendDrivingData(double x, double y) {
    final Map<String, dynamic> jsonData = {
      "x" : x,
      "y" : y
    };
    final String convertedJsonData = jsonEncode(jsonData);
    WebSocketManager().sendMessage(convertedJsonData);
    print("sent message: $convertedJsonData");
  }

}
