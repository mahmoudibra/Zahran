abstract class BaseException implements Exception {
  String statusCode();

  String message();
}

class ServerException implements BaseException {
  @override
  String message() => "Server Error, Please Try Again Later";

  @override
  String statusCode() => "500";
}

class BadRequestException implements BaseException {
  @override
  String message() => "Bad Request, Please Try Again Later";

  @override
  String statusCode() => "400";
}

class PageNotFoundException implements BaseException {
  @override
  String message() => "Page Not Found, Please Try Again Later";

  @override
  String statusCode() => "404";
}

class UnauthorizedException implements BaseException {
  @override
  String message() => "Your Request isn't Authorized";

  @override
  String statusCode() => "401";
}

class NoInternetException implements BaseException {
  @override
  String message() =>
      "No Internet Connection, please try to connect to a network";

  @override
  String statusCode() => "500";
}

class BackEndException implements Exception {
  int code;
  String message;

  BackEndException({this.code, this.message});

  factory BackEndException.fromJson(Map<String, dynamic> json) {
    return BackEndException(code: json['code'], message: json['message']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}
