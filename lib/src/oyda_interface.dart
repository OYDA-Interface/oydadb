import 'package:oydadb/oydadb.dart';

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

  Future<void> setOydaBase(String host, String port, String oydaBase, String user, String password) async {
    await connectionManager.setOydaBase(host, port, oydaBase, user, password);
  }

  Future<List<Map<String, dynamic>>> selectTable(String tableName) async {
    return await tableManager.selectTable(tableName);
  }

  Future<bool> tableExists(String tableName) async {
    return await tableManager.tableExists(tableName);
  }

  Future<void> dropTable(String tableName) async {
    await tableManager.dropTable(tableName);
  }

  Future<List<Map<String, dynamic>>> selectRows(String tableName, List<Condition> conditions) async {
    return await DataManager(connectionManager).selectRows(tableName, conditions);
  }

  Future<List<Map<String, dynamic>>> selectColumns(String tableName, List<String> columns,
      [List<Condition>? conditions]) async {
    return await DataManager(connectionManager).selectColumns(tableName, columns, conditions);
  }
}
