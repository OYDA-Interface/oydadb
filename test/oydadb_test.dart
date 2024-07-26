// ignore_for_file: avoid_print

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oydadb/oydadb.dart';
import 'package:oydadb/src/oyda_interface.dart';

void main() {
  // Test the OYDAInterface class

  group('OYDAInterface', () {
    // String host = 'localhost';
    // String port = '5432';
    // String oydaBase = 'oyda_db';
    // String user = 'oydaadmin';
    // String password = 'none';

    // test('change/update current oydabase', () async {
    //   await dotenv.load(fileName: ".env");
    //   await OydaInterface().setOydaBase(host, port, oydaBase, user, password);
    // });

    // test('double setOydaBase', () async {
    //   await dotenv.load(fileName: ".env");
    //   await OydaInterface().setOydaBase(host, port, oydaBase, user, password);
    //   await OydaInterface().setOydaBase(host, port, oydaBase, user, password);
    // });

    test('create table', () async {
      await dotenv.load(fileName: ".env");
      await OydaInterface()
          .createTable('newtable1', {'name': 'VARCHAR(255)', 'age': 'INTEGER'});
    });

    test('select table', () async {
      await dotenv.load(fileName: ".env");
      var table = await OydaInterface().selectTable('newtable1');
      print(table);
    });

    test('insert row', () async {
      await dotenv.load(fileName: ".env");
      await OydaInterface()
          .insertRow('newtable1', {'name': 'Kofi', 'age': 14});
    });

    test('update row', () async {
      await dotenv.load(fileName: ".env");
      await OydaInterface().updateRow('newtable1',
          {'name': 'Dennis', 'age': 25}, [Condition('name', '=', 'Dennis')]);
    });

    test('delete row', () async {
      await dotenv.load(fileName: ".env");
      await OydaInterface()
          .deleteRow('newtable1', [Condition('name', '=', 'Dennis')]);
    });

    // test('check if table exists', () async {
    //   await dotenv.load(fileName: ".env");
    //   print(await OydaInterface().tableExists('test'));
    //   var table = await OydaInterface().selectTable('test');
    //   print(table);
    // });

    // test('select rows', () async {
    //   await dotenv.load(fileName: ".env");
    //   var rows = await OydaInterface().selectRows('test', [Condition('age', '=', 24)]);
    //   print(rows);
    // });

    // test('select columns', () async {
    //   await dotenv.load(fileName: ".env");

    //   var columns1 = await OydaInterface().selectColumns('test', ['name']);
    //   print(columns1);

    //   var columns2 = await OydaInterface().selectColumns('test', ['name'], [Condition('name', '=', 'king')]);
    //   print(columns2);
    // });

    // test('drop table', () async {
    //   await dotenv.load(fileName: ".env");
    //   var table = await OydaInterface().selectTable('test');
    //   print(table);
    //   await OydaInterface().dropTable('test3');
    // });
  });
}
