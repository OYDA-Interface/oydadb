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
      'table_name': '${devKey}_$tableName',
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
    final additionalParams = {
      'table_name': tableName,
      'columns': columns,
      'conditions': conditionString,
    };
    return await connectionManager.sendRequest(
        '/api/select_columns', additionalParams);
  }
}
