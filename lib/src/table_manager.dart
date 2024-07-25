// ignore_for_file: avoid_print

import 'package:oydadb/oydadb.dart';

/// The `TableManager` class is responsible for managing table operations.
class TableManager {
  final ConnectionManager connectionManager;

  /// Constructs a `TableManager` with the given `connectionManager`.
  TableManager(this.connectionManager);

  /// Creates a new table in the oydabase with the .
  ///
  /// The `tableName` parameter specifies the name of the table to select from.
  /// The `columns` parameter specifies the columns of the table to create.
  /// Returns a `Future` that completes with a list of maps, where each map represents a row in the table.
  Future<List<Map<String, dynamic>>> createTable(
      String tableName, Map<String, dynamic> columns) async {
    String? devKey = connectionManager.devKey;
    final additionalParams = {
      'table_name': '$tableName{_$devKey}',
      'columns': columns
    };
    return await connectionManager.sendRequest(
        '/api/create_table', additionalParams);
  }

  /// Selects all rows from the specified table and returns them as a list of maps.
  ///
  /// The `tableName` parameter specifies the name of the table to select from.
  /// Returns a `Future` that completes with a list of maps, where each map represents a row in the table.
  Future<List<Map<String, dynamic>>> selectTable(String tableName) async {
    String? devKey = connectionManager.devKey;
    final additionalParams = {
      'table_name': '$tableName{_$devKey}',
    };
    return await connectionManager.sendRequest(
        '/api/select_table', additionalParams);
  }

  /// Checks if the specified table exists in the database.
  ///
  /// The `tableName` parameter specifies the name of the table to check.
  /// Returns a `Future` that completes with a boolean value indicating whether the table exists.
  Future<bool> tableExists(String tableName) async {
    String? devKey = connectionManager.devKey;
    final additionalParams = {
      'table_name': '$tableName{_$devKey}',
    };
    return await connectionManager.sendRequest(
        '/api/table_exists', additionalParams);
  }

  /// Drops the specified table from the database.
  ///
  /// The `tableName` parameter specifies the name of the table to drop.
  /// Returns a `Future` that completes when the table is dropped.
  Future<void> dropTable(String tableName) async {
    String? devKey = connectionManager.devKey;
    final additionalParams = {
      'table_name': '$tableName{_$devKey}',
    };
    return await connectionManager.sendRequest(
        '/api/drop_table', additionalParams);
  }
}
