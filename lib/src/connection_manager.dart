// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:http/http.dart' as http;

class ConnectionManager {
  String? host;
  String? port;
  String? oydaBase;
  String? user;
  String? password;

  static ConnectionManager? _instance;

  ConnectionManager._internal();

  factory ConnectionManager() {
    _instance ??= ConnectionManager._internal();
    return _instance!;
  }

  Future<void> setOydaBase(String? host, String? port, String? oydaBase, String? user, String? password) async {
    if (host == null || port == null || oydaBase == null || user == null || password == null) {
      throw Exception('Missing required parameters for setting the oydabase.');
    }

    if (this.oydaBase != null &&
        this.oydaBase == oydaBase &&
        this.host != null &&
        this.host == host &&
        this.port != null &&
        this.port == port &&
        this.user != null &&
        this.user == user &&
        this.password != null &&
        this.password == password) {
      print('Oydabase already set to "$oydaBase".');
      return;
    }

    final url = Uri.parse('http://localhost:5000/api/setOydabase');
    final Map<String, dynamic> requestBody = {
      'host': host,
      'port': port,
      'oydaBase': oydaBase,
      'user': user,
      'password': password,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        this.host = host;
        this.port = port;
        this.oydaBase = oydaBase;
        this.user = user;
        this.password = password;

        final responseBody = jsonDecode(response.body);
        print(responseBody['message'] ?? 'Oydabase set successfully');
      } else {
        final responseBody = jsonDecode(response.body);
        throw '${responseBody['error']}';
      }
    } catch (e) {
      throw Exception('Error connecting to the oydabase: $e');
    }
  }
}
