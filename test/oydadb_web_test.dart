// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';
import 'package:oydadb_web/oydadb_web.dart';
import 'package:oydadb_web/src/oyda_interface.dart';

void main() {
  // Test the OYDAInterface class
  String host = 'localhost';
  String port = '5432';
  String oydaBase = 'oyda_db';
  String user = 'oydaadmin';
  String password = 'none';

  group('OYDAInterface', () {
    test('setOydaBase', () async {
      final oydaInterface = OydaInterface();
      await oydaInterface.setOydaBase(host, port, oydaBase, user, password);
    });

    test('double setOydaBase', () async {
      final oydaInterface = OydaInterface();
      await oydaInterface.setOydaBase(host, port, oydaBase, user, password);
      await oydaInterface.setOydaBase(host, port, oydaBase, user, password);
    });

    test('select table', () async {
      final oydaInterface = OydaInterface();
      await oydaInterface.setOydaBase(host, port, oydaBase, user, password);
      var table = await oydaInterface.selectTable('test');
      print(table);
    });
    test('drop table', () async {
      final oydaInterface = OydaInterface();
      await oydaInterface.setOydaBase(host, port, oydaBase, user, password);
      var table = await oydaInterface.selectTable('test');
      print(table);
      await oydaInterface.dropTable('test');
      // await TableManager(oydaInterface).selectTable('test');
    });


  });
}
