// ignore_for_file: avoid_print

import 'package:oydadb_web/oydadb_web.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class TableManager {
  final ConnectionManager connectionManager;

  TableManager(this.connectionManager);

  Future<List<Map<String, dynamic>>> selectTable(String tableName) async {
    if (connectionManager.host == null ||
        connectionManager.port == null ||
        connectionManager.oydaBase == null ||
        connectionManager.user == null ||
        connectionManager.password == null) {
      throw Exception('Connection parameters are not set.');
    }

    final url = Uri.parse('http://localhost:5000/api/selectTable');
    final Map<String, dynamic> requestBody = {
      'host': connectionManager.host,
      'port': connectionManager.port,
      'oydaBase': connectionManager.oydaBase,
      'user': connectionManager.user,
      'password': connectionManager.password,
      'table_name': tableName,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body) as List<dynamic>;
        return result.map((e) => e as Map<String, dynamic>).toList();
      } else {
        final responseBody = jsonDecode(response.body);
        throw Exception('${responseBody['error']}');
      }
    } catch (e) {
      throw Exception('Error connecting to the oydabase: $e');
    }
  }

  Future<void> dropTable(String tableName) async {
    if (connectionManager.host == null ||
        connectionManager.port == null ||
        connectionManager.oydaBase == null ||
        connectionManager.user == null ||
        connectionManager.password == null) {
      throw Exception('Connection parameters are not set.');
    }

    final url = Uri.parse('http://localhost:5000/api/dropTable');
    final Map<String, dynamic> requestBody = {
      'host': connectionManager.host,
      'port': connectionManager.port,
      'oydaBase': connectionManager.oydaBase,
      'user': connectionManager.user,
      'password': connectionManager.password,
      'table_name': tableName,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print(responseBody['message'] ?? 'Table "$tableName" dropped successfully');
        return;
      } else {
        final responseBody = jsonDecode(response.body);
        throw Exception('${responseBody['error']}');
      }
    } catch (e) {
      throw Exception('Error connecting to the oydabase: $e');
    }
  }
}
