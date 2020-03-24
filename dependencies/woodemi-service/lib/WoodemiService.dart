import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

import 'common.dart';
import 'model.dart';

class WoodemiServiceHeader {
  static Map<String, String> json = {
    'Content-Type': 'application/json; charset=utf-8',
  };

  static Map<String, String> image = {
    'Content-Type': 'multipart/form-data',
  };
}

class WoodemiService {
  static ClientAgent clientAgent;
  static String operationSystem = 'Unknown';
  static String operatingSystemVersion = 'Unknown';

  final _logger = Logger("WoodemiService");

  int get appId => clientAgent.appId;

  Map<String, Object> _systemData;

  Future<Map<String, Object>> get systemData async {
    if (_systemData != null) return _systemData;
    _systemData = {
      'appId': '$appId',
    };
    return _systemData;
  }

  Object parseJsonData(String bodyString) {
    try {
      _logger.info('response = $bodyString');
      var json = jsonDecode(bodyString);
      var response = WoodemiResponse.fromMap(json);
      if (response.status.statuscode != WoodemiStatus.success) {
        throw WoodemiException(response.status);
      }
      return response.data;
    } on WoodemiException catch (e) {
      rethrow;
    } catch (e) {
      // In case of jsonDecode error
      _logger.severe('parseJsonData $bodyString');
      throw NetException(0, bodyString);
    }
  }

  Future<Object> getJson(String url, [Map<String, Object> params]) async {
    var resultParams = await _resultParams(params);
    print('---------------------getJson---------------------');
    print('url = ${url}');
    print('params = ${params}');
    print('resultParams = ${resultParams}');
    var uri = Uri.parse(url).replace(queryParameters: resultParams).toString();
    var response = await http.get(uri);
    return parseJsonData(response.body);
  }

  /// Default to [ContentType.json]
  Future<Object> postJson(String url, Map<String, Object> params) async {
    var resultParams = await _resultParams(params);

    _logger.info('---------------------postJson---------------------');
    _logger.info('url = ${url}');
    _logger.info('params = ${params}');
    _logger.info('resultParams = ${resultParams}');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(resultParams),
    );
    return parseJsonData(response.body);
  }

  /// Default to [ContentType.json]
  Future<Object> putJson(String url, Map<String, Object> params) async {
    var resultParams = await _resultParams(params);

    _logger.info('---------------------putJson---------------------');
    _logger.info('url = ${url}');
    _logger.info('params = ${params}');
    _logger.info('resultParams = ${resultParams}');
    var response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(resultParams),
    );
    return parseJsonData(response.body);
  }

  Future<Object> deleteJson(String url, Map<String, Object> queryParameters,
      {Map<String, Object> params}) async {
    var resultParams = await _resultParams(params);

    _logger.info('---------------------deleteJson---------------------');
    _logger.info('url = ${url}');
    _logger.info('params = ${params}');
    _logger.info('resultParams = ${resultParams}');
    _logger.info('queryParameters = ${queryParameters}');
    var uri = Uri.parse(url).replace(queryParameters: queryParameters);
    var response = await delete(uri, resultParams);
    return parseJsonData(response.body);
  }

  _resultParams(Map<String, Object> params) async {
    var resultParams = Map<String, Object>();
    resultParams.addAll(await systemData);
    if (params != null) resultParams.addAll(params);
    return resultParams;
  }
}

// FIXME https://github.com/dart-lang/http/issues/206
@visibleForTesting
Future<http.Response> delete(Uri uri, Map<String, Object> params) async {
  var client = http.Client();
  try {
    var request = http.Request('DELETE', uri);
    if (params != null) {
      request.headers.addAll({
        'Content-Type': 'application/json; charset=utf-8',
      });
      request.body = jsonEncode(params);
    }
    var streamedResponse = await client.send(request);
    return await http.Response.fromStream(streamedResponse);
  } finally {
    client.close();
  }
}