import 'package:oydadb/oydadb.dart';

/// The `DataManager` class is responsible for managing data operations.
class DataManager {
  final ConnectionManager connectionManager;

  /// Constructs a `DataManager` instance with the given `connectionManager`.
  DataManager(this.connectionManager);

  /// Selects rows from the specified `tableName` based on the given `conditions`.
  ///
  /// Returns a `Future` that completes with a list of maps representing the selected rows.
  Future<List<Map<String, dynamic>>> selectRows(
      String tableName, List<Condition> conditions) async {
    final conditionString =
        conditions.map((condition) => condition.toString()).join(' AND ');
    String? devKey = connectionManager.devKey;
    final additionalParams = {
      'table_name': '${tableName}_$devKey',
      'conditions': conditionString,
    };
    return await connectionManager.sendRequest(
        '/api/select_rows', additionalParams);
  }

  /// Selects specific `columns` from the specified `tableName` based on the given `conditions`.
  ///
  /// Returns a `Future` that completes with a list of maps representing the selected columns.
  Future<List<Map<String, dynamic>>> selectColumns(
      String tableName, List<String> columns,
      [List<Condition>? conditions]) async {
    final conditionString =
        conditions?.map((condition) => condition.toString()).join(' AND ') ??
            '';
    String? devKey = connectionManager.devKey;
    final additionalParams = {
      'table_name': '${tableName}_$devKey',
      'columns': columns,
      'conditions': conditionString,
    };
    return await connectionManager.sendRequest(
        '/api/select_columns', additionalParams);
  }

  Future<void> insertRow(String tableName, Map<String, dynamic> row) async {
    String? devKey = connectionManager.devKey;
    final additionalParams = {
      'table_name': '${tableName}_$devKey',
      'row': row,
    };
    await connectionManager.sendRequest('/api/insert_row', additionalParams);
  }

  Future<void> updateRow(String tableName, Map<String, dynamic> row,
      List<Condition> conditions) async {
    final conditionString =
        conditions.map((condition) => condition.toString()).join(' AND ');
    String? devKey = connectionManager.devKey;
    final additionalParams = {
      'table_name': '${tableName}_$devKey',
      'row': row,
      'condition': conditionString,
    };
    await connectionManager.sendRequest('/api/update_row', additionalParams);
  }

  Future<void> deleteRow(String tableName, List<Condition> conditions) async {
    final conditionString =
        conditions.map((condition) => condition.toString()).join(' AND ');
    String? devKey = connectionManager.devKey;
    final additionalParams = {
      'table_name': '${tableName}_$devKey',
      'condition': conditionString,
    };
    await connectionManager.sendRequest('/api/delete_row', additionalParams);
  }
}
