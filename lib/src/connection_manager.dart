// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// The `ConnectionManager` class provides methods for setting up and managing the connection parameters
/// required to connect to the Oydabase server. It ensures only one instance of `ConnectionManager` is created
/// and provides a static method to access that instance. It also includes methods for sending requests to the server
/// and handling the responses.
class ConnectionManager {
  String? host = dotenv.env['HOST']!;
  String? port = dotenv.env['PORT']!;
  String? oydaBase = dotenv.env['OYDA_BASE']!;
  String? user = dotenv.env['USER']!;
  String? password = dotenv.env['PASSWORD']!;
  String? devKey = dotenv.env['DEV_KEY'];

  static ConnectionManager? _instance;

  ConnectionManager._internal();

  factory ConnectionManager() {
    _instance ??= ConnectionManager._internal();
    return _instance!;
  }

  /// Checks if all the required connection parameters are provided.
  ///
  /// Throws an exception if any of the required parameters (host, port, oydaBase, user, password) is missing.
  void checkConnectionParams() {
    if (host == null ||
        port == null ||
        oydaBase == null ||
        user == null ||
        password == null ||
        devKey == null) {
      throw Exception('Missing required parameters for setting the oydabase.');
    }
  }

  /// Retrieves the connection parameters as a map.
  ///
  /// This method returns a map containing the connection parameters required to establish a connection to the database.
  /// The connection parameters include the host, port, oydaBase, user, and password.
  /// An optional `additionalParams` parameter can be provided to include any additional connection parameters.
  /// If `additionalParams` is provided, the additional parameters will be merged with the default parameters.
  ///
  /// Returns:
  ///   - A map containing the connection parameters.
  Map<String, dynamic> getConnectionParams(
      [Map<String, dynamic>? additionalParams]) {
    checkConnectionParams();
    final Map<String, dynamic> params = {
      'host': host,
      'port': port,
      'oydaBase': oydaBase,
      'user': user,
      'password': password,
      'devKey': devKey
    };
    if (additionalParams != null) {
      params.addAll(additionalParams);
    }
    return params;
  }

  /// Sends a request to the specified `endpoint` with the given `additionalParams`.
  ///
  /// This method returns a `Future` that resolves to the response of the request.
  /// The type of the response is specified by the generic type parameter `T`.
  ///
  /// Example usage:
  /// ```dart
  /// final response = await sendRequest<MyResponse>('https://example.com/api', {'param1': 'value1'});
  /// ```
  Future<T> sendRequest<T>(
      String endpoint, Map<String, dynamic> additionalParams) async {
    final requestBody = getConnectionParams(additionalParams);

    final url = Uri.parse('http://oydabackend.azurewebsites.net$endpoint');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        if (T == List<Map<String, dynamic>>) {
          final result = responseBody as List<dynamic>;
          return result.map((e) => e as Map<String, dynamic>).toList() as T;
        } else if (T == bool) {
          return responseBody['exists'] as T;
        } else {
          return null as T;
        }
      } else {
        final responseBody = jsonDecode(response.body);
        throw Exception('Error: ${responseBody['error']}');
      }
    } on http.ClientException catch (e) {
      throw Exception('Error connecting to the Oydabase: $e');
    } on FormatException catch (e) {
      throw Exception('Format error: $e');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @Deprecated(
      "Set the oydabase from the oydacli instead. This method will be removed in the future.")

  /// Sets the OYDA base configuration.
  ///
  /// The `host` parameter specifies the host address.
  /// The `port`parameter specifies the port number.
  /// The `oydaBase` parameter specifies the OYDA base.
  /// The `user` parameter specifies the username.
  /// The `password` parameter specifies the password.
  ///
  /// Returns a `Future` that completes when the OYDA base is set.
  Future<void> setOydaBase(String? host, String? port, String? oydaBase,
      String? user, String? password) async {
    if (host == null ||
        port == null ||
        oydaBase == null ||
        user == null ||
        password == null) {
      throw Exception('Missing required parameters for setting the oydabase.');
    }

    if (this.oydaBase != null &&
        this.oydaBase == oydaBase &&
        this.host != null &&
        this.host == host &&
        this.port != null &&
        this.port == port &&
        this.user != null &&
        this.user == user &&
        this.password != null &&
        this.password == password) {
      print('Oydabase already set to "$oydaBase".');
      return;
    }

    final url =
        Uri.parse('http://oydabackend.azurewebsites.net/api/set_oydabase');
    final Map<String, dynamic> requestBody = {
      'host': host,
      'port': port,
      'oydaBase': oydaBase,
      'user': user,
      'password': password,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        dotenv.env['HOST'] = host;
        dotenv.env['PORT'] = port;
        dotenv.env['OYDA_BASE'] = oydaBase;
        dotenv.env['USER'] = user;
        dotenv.env['PASSWORD'] = password;
        this.host = host;
        this.port = port;
        this.oydaBase = oydaBase;
        this.user = user;
        this.password = password;

        final responseBody = jsonDecode(response.body);
        print(responseBody['message'] ??
            'Connected to Oydabase @ $host:$port/$oydaBase.');
      } else {
        final responseBody = jsonDecode(response.body);
        throw '${responseBody['error']}';
      }
    } catch (e) {
      throw Exception('Error connecting to the Oydabase: $e');
    }
  }

  /// Unsets the Oydabase.
  ///
  /// This method is used to unset the Oydabase. It does not return any value.
  /// Example usage:
  /// ```dart
  /// await unsetOydabase();
  /// ```
  Future<void> unsetOydabase() async {
    host = null;
    port = null;
    oydaBase = null;
    user = null;
    password = null;
    print('Oydabase unset successfully');
  }
}
