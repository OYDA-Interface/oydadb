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

    test('tableExists', () async {
      final oydaInterface = OydaInterface();
      await oydaInterface.setOydaBase(host, port, oydaBase, user, password);
      print(await oydaInterface.tableExists('test'));
      var table = await oydaInterface.selectTable('test');
      print(table);
    });

    test('select rows', () async {
      final oydaInterface = OydaInterface();
      await oydaInterface.setOydaBase(host, port, oydaBase, user, password);
      var rows = await oydaInterface.selectRows('test', [Condition('age', '=', 24)]);
      print(rows);
    });

    test('select columns', () async {
      final oydaInterface = OydaInterface();
      await oydaInterface.setOydaBase(host, port, oydaBase, user, password);

      var columns1 = await oydaInterface.selectColumns('test', ['name']);
      print(columns1);

      var columns2 =
          await oydaInterface.selectColumns('test', ['name'], [Condition('name', '=', 'king')]);
      print(columns2);
    });

    // test('drop table', () async {
    //   final oydaInterface = OydaInterface();
    //   await oydaInterface.setOydaBase(host, port, oydaBase, user, password);
    //   var table = await oydaInterface.selectTable('test');
    //   print(table);
    //   await oydaInterface.dropTable('test3');
    // });
  });
}
