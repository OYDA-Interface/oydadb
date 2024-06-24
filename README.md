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

Create an instance of the `OYDAInterface` class:

```dart
final oydaInterface = OYDAInterface();
```

Set up the database connection:

```dart
await oydaInterface.setOydaBase(devKey, oydabaseName, host, port, username, password, useSSL);
```

Please replace the placeholders with your actual values and add more details as necessary.

Now, you can use the `oydaInterface` instance to interact with your PostgreSQL database. For example, to create a table:

```dart
const tableName = 'test_table';
final columns = {
  'id': 'SERIAL PRIMARY KEY',
  'name': 'VARCHAR(255)',
  'age': 'INTEGER',
};
await oydaInterface.createTable(tableName, columns);
```

This first version of the OYDA Interface, featuring the `oydadb` package, is a significant step towards making database operations in Flutter applications more straightforward and efficient, and enabling independent collaborative development.

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
