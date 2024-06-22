// ignore_for_file: avoid_print

import 'package:oydadb/oydadb.dart';


class TableManager {
  final ConnectionManager connectionManager;

  TableManager(this.connectionManager);

  Future<List<Map<String, dynamic>>> selectTable(String tableName) async {
    final additionalParams = {'table_name': tableName};
    return await connectionManager.sendRequest('/api/selectTable', additionalParams);
  }

  Future<bool> tableExists(String tableName) async {
    final additionalParams = {'table_name': tableName};
    return await connectionManager.sendRequest('/api/tableExists', additionalParams);
  }

  Future<void> dropTable(String tableName) async {
    final additionalParams = {'table_name': tableName};
    return await connectionManager.sendRequest('/api/dropTable', additionalParams);
  }
}
