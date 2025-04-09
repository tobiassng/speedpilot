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
  
  void listenSpeed(void Function(double) onSpeedReceived) {
    _webSocket.listen((data) {
      final speed = double.tryParse(data.toString());
      if (speed != null) {
        onSpeedReceived(speed); 
        print("Nachricht empfangen: $speed");
      } else {
        print("Ungültige Nachricht empfangen: $data");
      }
    });
  }

  void closeConnection() {
    _webSocket.close();
    print("WebSocket-Verbindung geschlossen");
  }

  void sendDrivingData(double x, double y) {
    final Map<String, dynamic> jsonData = {
      "x": x,
      "y": y
    };
    final String convertedJsonData = jsonEncode(jsonData);
    sendMessage(convertedJsonData);
    print("sent message: $convertedJsonData");
  }
}
