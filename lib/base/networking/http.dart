import 'dart:convert';
import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:mjaa_web/base/constants/_index.dart';

import 'interceptor.dart';
import 'outcome.dart';

final baseURL = '${dotenv.env["BASE_URL"]}';
enum Method { GET, POST, PUT, DELETE }

class HttpService {
  var _api = new _Api();

  Future<Outcome> httpGet({
    String endPoint = "",
    Map<String, dynamic>? query,
    bool withToken = true,
  }) async {
    return await _api.httpGet(
        endPoint: endPoint, query: query, withToken: withToken);
  }

  Future<Outcome> httpPost({
    String endPoint = "",
    dynamic body,
    bool withToken = true,
  }) async {
    return await _api.httpPost(
        endPoint: endPoint, body: body, withToken: withToken).timeout(Duration(minutes: 5));
  }

  Future<Outcome> httpPut({
    String endPoint = "",
    dynamic body,
    bool withToken = true,
  }) async {
    return await _api.httpPut(
        endPoint: endPoint, body: body, withToken: withToken);
  }

  Future<Outcome> httpPatch({
    String endPoint = "",
    dynamic body,
    bool withToken = true,
  }) async {
    return await _api.httpPatch(
        endPoint: endPoint, body: body, withToken: withToken);
  }

  Future<Outcome> httpDelete({
    String endPoint = "",
    Map<String, dynamic>? query,
    bool withToken = true,
  }) async {
    return await _api.httpDelete(endPoint: "$endPoint", query: query, withToken: withToken);
  }

  Future<Outcome> httpUploadMultipart({
    String endPoint = "",
    required File file,
    required String filename,
    bool withToken = true,
  }) async {
    return await _api.httpUploadMultipart(
        endPoint: endPoint,
        file: file,
        fileName: filename,
        withToken: withToken);
  }

  Future<Outcome> httpManual({
    required Method method,
    required String url,
    Map<String, String>? header,
    Map<String, String>? query,
    Map? body,
  }) async {
    return await _api.httpManual(
      method: method,
      url: url,
      header: header,
      query: query,
      body: body,
    );
  }
}

// —————————————————————————————————————————————————————————————————————————————
/// PRIVATE CLASS
/// configure http here !!
// —————————————————————————————————————————————————————————————————————————————
class _Api extends GetConnect {
  bool _withToken = false;

  @override
  void onInit() {
    prepareHeader();
    httpClient.timeout = const Duration(seconds: 60);
    super.onInit();
  }

  Future<void> prepareHeader() async {
    httpClient.errorSafety = true;
    httpClient.baseUrl = baseURL;

    httpClient.addRequestModifier<void>((request) async {
      if (_withToken) {
        String? token = pref.read(PREF_TOKEN) ?? EMPTY;
        if (token.isNotBlank) {
          request.headers['Authorization'] = "Bearer $token";
        }
      }

      print("HEADERS ${request.headers}");

      return request;
    });
  }

  Future<void> prepareHeaderUrlEncoded() async {
    httpClient.errorSafety = true;
    httpClient.baseUrl = baseURL;

    // HEADER
    String contentType = 'application/json';

    httpClient.addRequestModifier<void>((request) async {
      if (_withToken) {
        String? token = pref.read(PREF_TOKEN) ?? EMPTY;
        if (token.isNotBlank) {
          request.headers['Authorization'] = "Bearer $token";
        }
      }
      request.headers['content-type'] = "$contentType";

      print("HEADERS ${request.headers}");

      return request;
    });
  }

  Future<Outcome> httpGet({
    required String endPoint,
    Map<String, dynamic>? query,
    bool withToken = false,
  }) async {
    var _result = Outcome();
    _withToken = withToken;
    await prepareHeader();

    print("GET     : ${httpClient.baseUrl}$endPoint");
    try {
      if (query != null) print("QUERY   : ${jsonEncode(query)}");
    } catch (e) {
      if (query != null) print("QUERY   : $query");
    }
    if (withToken) print("TOKEN   : ${pref.read(PREF_TOKEN)}");

    try {
      httpClient.timeout = const Duration(seconds: 120);
      var res = await get(endPoint, query: query);
      print("RESPONSE CODE : ${res.statusCode}");

      if (res.isOk) {
        print("${res.bodyString}");
        _result.body = res.body;
        _result.isFailure = false;
        return _result;
      } else {
        return errorInterceptorHandling(res, _result);
      }
    } catch (e) {
      return errorInterceptorHandling(e, _result);
    }
  }

  Future<Outcome> httpManual({
    required Method method,
    required String url,
    Map<String, String>? header,
    Map<String, String>? query,
    Map? body,
  }) async {
    var _result = Outcome();
    httpClient.baseUrl = EMPTY;
    print("GET     : $url");
    try {
      httpClient.timeout = const Duration(seconds: 120);
      var res;
      switch (method) {
        case Method.GET:
          res = await get(url, query: query, headers: header);
          break;
        case Method.POST:
          res = await post(url, body, headers: header);
          break;
        case Method.PUT:
          res = await put(url, body, headers: header);
          break;
        case Method.DELETE:
          res = await delete(url, headers: header, query: query);
          break;
        default:
          res = await get(url, query: query, headers: header);
          break;
      }
      print("RESPONSE CODE : $res");
      if (res.isOk) {
        print("${jsonEncode(res.bodyString)}");
        _result.body = res.body;
        _result.isFailure = false;
        return _result;
      } else {
        return errorInterceptorHandling(res, _result);
      }
    } catch (e) {
      return errorInterceptorHandling(e, _result);
    }
  }

  // —————————————————————————————————————————————————————————————————————————————
  // [POST]
  // —————————————————————————————————————————————————————————————————————————————
  Future<Outcome> httpPost({
    String endPoint = "",
    dynamic body,
    bool withToken = true,
  }) async {
    var _result = Outcome();
    _withToken = withToken;
    await prepareHeaderUrlEncoded().timeout(Duration(minutes: 5));

    print("POST    : ${httpClient.baseUrl}$endPoint");
    try {
      if (body != null) print("PAYLOAD : ${jsonEncode(body)}");
    } catch (e) {
      if (body != null) print("PAYLOAD : $body");
    }
    if (withToken) print("TOKEN   : ${pref.read(PREF_TOKEN)}");

    try {
      httpClient.timeout = const Duration(seconds: 120);
      var res = await httpClient.post(endPoint,
          contentType: 'application/json', body: body).timeout(Duration(minutes: 5));
      print("RESPONSE CODE : ${res.statusCode}");

      if (res.isOk) {
        print("${res.bodyString}");
        _result.body = res.body;
        _result.isFailure = false;
        return _result;
      } else {
        return errorInterceptorHandling(res, _result);
      }
    } catch (e) {
      return errorInterceptorHandling(e, _result);
    }
  }

  // —————————————————————————————————————————————————————————————————————————————
  // [PUT]
  // —————————————————————————————————————————————————————————————————————————————
  Future<Outcome> httpPut({
    String endPoint = "",
    dynamic body,
    bool withToken = true,
  }) async {
    var _result = Outcome();
    _withToken = withToken;
    await prepareHeader();

    print("PUT     : ${httpClient.baseUrl}$endPoint");
    try {
      if (body != null) print("PAYLOAD : ${jsonEncode(body)}");
    } catch (e) {
      if (body != null) print("PAYLOAD : $body");
    }
    if (withToken) print("TOKEN   : ${pref.read(PREF_TOKEN)}");

    try {
      httpClient.timeout = const Duration(seconds: 120);
      var res = await httpClient.put(endPoint, body: body);
      print("RESPONSE CODE : ${res.statusCode}");

      if (res.isOk) {
        print("${res.bodyString}");
        _result.body = res.body;
        _result.isFailure = false;
        return _result;
      } else {
        return errorInterceptorHandling(res, _result);
      }
    } catch (e) {
      return errorInterceptorHandling(e, _result);
    }
  }

  // —————————————————————————————————————————————————————————————————————————————
  // [PATCH]
  // —————————————————————————————————————————————————————————————————————————————
  Future<Outcome> httpPatch({
    String endPoint = "",
    dynamic body,
    bool withToken = true,
  }) async {
    var _result = Outcome();
    _withToken = withToken;
    await prepareHeader();

    print("PUT     : ${httpClient.baseUrl}$endPoint");
    try {
      if (body != null) print("PAYLOAD : ${jsonEncode(body)}");
    } catch (e) {
      if (body != null) print("PAYLOAD : $body");
    }
    if (withToken) print("TOKEN   : ${pref.read(PREF_TOKEN)}");

    try {
      httpClient.timeout = const Duration(seconds: 120);
      var res = await httpClient.patch(endPoint, body: body);
      print("RESPONSE CODE : ${res.statusCode}");

      if (res.isOk) {
        print("${res.bodyString}");
        _result.body = res.body;
        _result.isFailure = false;
        return _result;
      } else {
        return errorInterceptorHandling(res, _result);
      }
    } catch (e) {
      return errorInterceptorHandling(e, _result);
    }
  }

  // —————————————————————————————————————————————————————————————————————————————
  // [DELETE]
  // —————————————————————————————————————————————————————————————————————————————
  Future<Outcome> httpDelete({
    String endPoint = "",
    bool withToken = true,
    Map<String, dynamic>? query,
  }) async {
    var _result = Outcome();
    _withToken = withToken;
    await prepareHeaderUrlEncoded();

    print("DELETE  : ${httpClient.baseUrl}$endPoint");
    try {
      if (query != null) print("QUERY   : ${jsonEncode(query)}");
    } catch (e) {
      if (query != null) print("QUERY   : $query");
    }
    if (withToken) print("TOKEN   : ${pref.read(PREF_TOKEN)}");

    try {
      httpClient.timeout = const Duration(seconds: 120);
      var res = await httpClient.delete("$endPoint",
          query: query,
          contentType: 'application/json');
      print("RESPONSE CODE : ${res.statusCode}");

      if (res.isOk) {
        print("${res.bodyString}");
        _result.body = res.body;
        _result.isFailure = false;
        return _result;
      } else {
        return errorInterceptorHandling(res, _result);
      }
    } catch (e) {
      return errorInterceptorHandling(e, _result);
    }
  }

  Future<Outcome> httpUploadMultipart({
    String endPoint = "",
    required File file,
    required String fileName,
    bool withToken = true,
  }) async {
    var _result = Outcome();
    _withToken = withToken;
    await prepareHeader();

    print("UPLOAD  : ${httpClient.baseUrl}$endPoint");
    print("FILE    : $file");
    if (withToken) print("TOKEN   : ${pref.read(PREF_TOKEN)}");

    try {
      httpClient.timeout = const Duration(seconds: 120);
      final form = FormData({'file': MultipartFile(file, filename: fileName)});
      var res = await httpClient.post(endPoint, body: form);
      print("RESPONSE CODE : ${res.statusCode}");

      if (res.isOk) {
        print("${res.bodyString}");
        _result.body = res.body;
        _result.isFailure = false;
        return _result;
      } else {
        return errorInterceptorHandling(res, _result);
      }
    } catch (e) {
      return errorInterceptorHandling(e, _result);
    }
  }
}
