# oydadb

The `oydadb` package a powerful tool that simplifies interactions with PostgreSQL databases in Flutter applications. It encapsulates all necessary database operations within the `OYDAInterface` class, making it easier to perform CRUD operations.

## Getting Started

First, don't use this package yet, it's not ready

Then, add the `oydadb` package to your `pubspec.yaml` file:

```yaml
dependencies:
  oydadb: ^1.0.0
```

Then, run `flutter pub get` to fetch the package.

## Usage

Import the package in your Dart file:

```dart
import 'package:oydadb/oydadb.dart';
```

Set up the database connection:

```dart
await OydaInterface().setOydaBase(devKey, oydabaseName, host, port, username, password, useSSL);
```

Now, you can use the `oydaInterface` instance to interact with your PostgreSQL database. For example, to create a table:

```dart
const tableName = 'test_table';
final columns = {
  'id': 'SERIAL PRIMARY KEY',
  'name': 'VARCHAR(255)',
  'age': 'INTEGER',
};
await OydaInterface().createTable(tableName, columns);
```



