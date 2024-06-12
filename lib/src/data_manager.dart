import 'package:oydadb_web/oydadb_web.dart';

class DataManager {
  final ConnectionManager connectionManager;
  DataManager(this.connectionManager);

  Future<List<Map<String, dynamic>>> selectRows(String tableName, List<Condition> conditions) async {
    final conditionString = conditions.map((condition) => condition.toString()).join(' AND ');
    final additionalParams = {
      'table_name': tableName,
      'conditions': conditionString,
    };
    return await connectionManager.sendRequest('api/selectRows', additionalParams);
  }

  Future<List<Map<String, dynamic>>> selectColumns(String tableName, List<String> columns,
      [List<Condition>? conditions]) async {
    final conditionString = conditions?.map((condition) => condition.toString()).join(' AND ') ?? '';
    final additionalParams = {
      'table_name': tableName,
      'columns': columns,
      'conditions': conditionString,
    };
    return await connectionManager.sendRequest('api/selectColumns', additionalParams);
  }
}
