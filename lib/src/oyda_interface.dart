import 'package:oydadb_web/oydadb_web.dart';

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

  Future<void> dropTable(String tableName) async {
    await tableManager.dropTable(tableName);
  }
}
