import 'outcome.dart';

Outcome errorInterceptorHandling(res, Outcome result) {
  print("errorHandling : $res");
  try {
    switch (res.statusCode) {
      case 400:
        result.isFailure = true;
        try {
          print("ERROR ${res.statusCode} : ${res.bodyString}");
        } catch (e) {
          result.errorMessages = "Terjadi Kesalahan 400";
        }
        return result;
      case 401:
        result.isFailure = true;
        result.errorMessages = "Email atau Password Salah";
        print("ERROR ${res.statusCode} : ${res.bodyString}");
        return result;
      case 404:
        result.isFailure = true;
        result.errorMessages = "Path tidak ditemukan (404)";
        print("ERROR ${res.statusCode} : ${res.bodyString}");
        return result;
      case 405:
        result.isFailure = true;
        result.errorMessages = "Method not allowed (405)";
        print("ERROR ${res.statusCode} : ${res.bodyString}");
        return result;
      case 500:
        result.isFailure = true;
        try {
          print("ERROR ${res.statusCode} : ${res.bodyString}");
        } catch (e) {
          result.errorMessages = "Internal Server Error (500)";
        }
        print("ERROR ${res.statusCode} : ${res.bodyString}");
        return result;
      case 503:
        result.isFailure = true;
        try {
          print("ERROR ${res.statusCode} : ${res.bodyString}");
        } catch (e) {
          result.errorMessages = "Internal Server Error (503)";
        }
        print("ERROR ${res.statusCode} : ${res.bodyString}");
        return result;
      default: // offline
        result.isFailure = true;
        result.errorMessages = "Jaringan internet lambat, coba kembali";
        print("ERROR ${res.statusCode} : ${res.bodyString}");
        return result;
    }
  } catch (e) {
    result.isFailure = true;
    result.errorMessages = "$e";
    print("ERROR Exception : $e");
    return result;
  }
}
