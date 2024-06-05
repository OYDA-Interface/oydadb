// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class ConnectionManager {
  static String? _host;
  static String? _port;
  static String? _oydaBase;
  static String? _user;
  static String? _password;

  Future<void> setOydaBase(String? host, String? port, String? oydaBase, String? user, String? password) async {
    if (host == null || port == null || oydaBase == null || user == null || password == null) {
      throw Exception('Missing required parameters for setting the oydabase.');
    }

    if (_oydaBase == oydaBase && _host == host && _port == port && _user == user && _password == password) {
      print('Oydabase already set to "$_oydaBase", .');
    }

    _host = host;
    _port = port;
    _oydaBase = oydaBase;
    _user = user;
    _password = password;

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
        final responseBody = jsonDecode(response.body);
        print(responseBody['message'] ?? 'Oydabase set successfully');

      } else {
        final responseBody = jsonDecode(response.body);
        throw 'Error: ${responseBody['error']}';
      }
    } catch (e) {
      throw Exception('Error connecting to the oydabase: $e');
    }
  }
}