import 'package:oydadb/oydadb.dart';

/// The `OydaInterface` Class that provides an interface for interacting with the OYDA database.
class OydaInterface {
  final ConnectionManager connectionManager;
  final TableManager tableManager;

  OydaInterface._internal()
      : connectionManager = ConnectionManager(),
        tableManager = TableManager(ConnectionManager());

  factory OydaInterface() {
    return _instance;
  }

  static final OydaInterface _instance = OydaInterface._internal();

  @Deprecated('Use the `oydacli` to set the OYDA base configuration.')

  /// Sets the OYDA base configuration.
  ///
  /// This method is deprecated and will be removed in the future.
  /// It is recommended to set the OYDA base from the oydacli instead.
  Future<void> setOydaBase(String host, String port, String oydaBase,
      String user, String password) async {
    await connectionManager.setOydaBase(host, port, oydaBase, user, password);
  }

  Future<Map<String, dynamic>> createTable(String tableName, Map<String, dynamic> columns) async {
    return await tableManager.createTable(tableName, columns);
  }

  /// Selects all rows from the specified table.
  ///
  /// Returns a list of maps, where each map represents a row in the table.
  Future<List<Map<String, dynamic>>> selectTable(String tableName) async {
    return await tableManager.selectTable(tableName);
  }

  /// Checks if the specified table exists in the database.
  ///
  /// Returns `true` if the table exists, `false` otherwise.
  Future<bool> tableExists(String tableName) async {
    return await tableManager.tableExists(tableName);
  }

  /// Drops the specified table from the database.
  Future<void> dropTable(String tableName) async {
    await tableManager.dropTable(tableName);
  }

  /// Selects rows from the specified table based on the given conditions.
  ///
  /// Returns a list of maps, where each map represents a row in the table.
  Future<List<Map<String, dynamic>>> selectRows(
      String tableName, List<Condition> conditions) async {
    return await DataManager(connectionManager)
        .selectRows(tableName, conditions);
  }

  /// Selects specific columns from the specified table based on the given conditions.
  ///
  /// Returns a list of maps, where each map represents a row in the table.
  Future<List<Map<String, dynamic>>> selectColumns(
      String tableName, List<String> columns,
      [List<Condition>? conditions]) async {
    return await DataManager(connectionManager)
        .selectColumns(tableName, columns, conditions);
  }

  /// Inserts a row into the specified table.
  Future<void> insertRow(String tableName, Map<String, dynamic> row) async {
    await DataManager(connectionManager).insertRow(tableName, row);
  }

  /// Updates a row in the specified table based on the given conditions.
  Future<void> updateRow(String tableName, Map<String, dynamic> row,
      List<Condition> conditions) async {
    await DataManager(connectionManager).updateRow(tableName, row, conditions);
  }

  /// Deletes a row from the specified table based on the given conditions.
  Future<void> deleteRow(String tableName, List<Condition> conditions) async {
    await DataManager(connectionManager).deleteRow(tableName, conditions);
  }
}
