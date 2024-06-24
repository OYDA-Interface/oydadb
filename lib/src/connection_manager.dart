// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ConnectionManager {
  String? host = dotenv.env['HOST']!;
  String? port = dotenv.env['PORT']!;
  String? oydaBase = dotenv.env['OYDA_BASE']!;
  String? user = dotenv.env['USER']!;
  String? password = dotenv.env['PASSWORD']!;

  static ConnectionManager? _instance;

  ConnectionManager._internal();

  factory ConnectionManager() {
    _instance ??= ConnectionManager._internal();
    return _instance!;
  }

  void checkConnectionParams() {
    if (host == null || port == null || oydaBase == null || user == null || password == null) {
      throw Exception('Missing required parameters for setting the oydabase.');
    }
  }

  Map<String, dynamic> getConnectionParams([Map<String, dynamic>? additionalParams]) {
    checkConnectionParams();
    final Map<String, dynamic> params = {
      'host': host,
      'port': port,
      'oydaBase': oydaBase,
      'user': user,
      'password': password,
    };
    if (additionalParams != null) {
      params.addAll(additionalParams);
    }
    return params;
  }

  Future<T> sendRequest<T>(String endpoint, Map<String, dynamic> additionalParams) async {
    final requestBody = getConnectionParams(additionalParams);

    final url = Uri.parse('http://localhost:5000$endpoint');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        if (T == List<Map<String, dynamic>>) {
          final result = responseBody as List<dynamic>;
          return result.map((e) => e as Map<String, dynamic>).toList() as T;
        } else if (T == bool) {
          return responseBody['exists'] as T;
        } else {
          return null as T;
        }
      } else {
        final responseBody = jsonDecode(response.body);
        throw Exception('Error: ${responseBody['error']}');
      }
    } on http.ClientException catch (e) {
      throw Exception('Error connecting to the Oydabase: $e');
    } on FormatException catch (e) {
      throw Exception('Format error: $e');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
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
        dotenv.env['HOST'] = host;
        dotenv.env['PORT'] = port;
        dotenv.env['OYDA_BASE'] = oydaBase;
        dotenv.env['USER'] = user;
        dotenv.env['PASSWORD'] = password;
        this.host = host;
        this.port = port;
        this.oydaBase = oydaBase;
        this.user = user;
        this.password = password;

        final responseBody = jsonDecode(response.body);
        print(responseBody['message'] ?? 'Connected to Oydabase @ $host:$port/$oydaBase.');
      } else {
        final responseBody = jsonDecode(response.body);
        throw '${responseBody['error']}';
      }
    } catch (e) {
      throw Exception('Error connecting to the Oydabase: $e');
    }
  }

  Future<void> unsetOydabase() async {
    host = null;
    port = null;
    oydaBase = null;
    user = null;
    password = null;
    print('Oydabase unset successfully');
  }
}
