import 'package:flutter_test/flutter_test.dart';
import 'package:oydadb_web/oydadb_web.dart';

void main() {
  // Test the OYDAInterface class
  String host = 'localhost';
  String oydaBase = 'oyda_db';
  String username = 'oydaadmin';
  String password = 'None';
  String port = '5432';

  group('OYDAInterface', () {
    test('setOydaBase', () async {
      final oydaInterface = ConnectionManager();
      await oydaInterface.setOydaBase(host, port, oydaBase, username, password);
    });
  });
}
