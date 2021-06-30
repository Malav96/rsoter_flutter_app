class CustomException implements Exception {
  final title;
  final message;

  CustomException([this.title, this.message]);

  String toString() => message;
}

class UnknownHostException extends CustomException {
  UnknownHostException({String? title, String? message})
      : super(title, message);
}

class InternalServerErrorExceptions extends CustomException {
  InternalServerErrorExceptions({String? title, String? message})
      : super(title, message);
}

class UnAuthorizedException extends CustomException {
  UnAuthorizedException({String? title, String? message})
      : super(title, message);
}

class ApiSideExceptions extends CustomException {
  ApiSideExceptions({String? title, String? message}) : super(title, message);
}
