// ignore_for_file: prefer_typing_uninitialized_variables

class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message])
      : super(message, "Unexpected error while connecting to the server ");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "unexpected error");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "Signed out");
}

class NotFoundException extends CustomException {
  NotFoundException([message]) : super(message, "Not found");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String? message]) : super(message, "Data entry error");
}

class InvalidEmailException extends CustomException {
  InvalidEmailException([String? message]) : super(message, "email Exception");
}

class TimeOutException extends CustomException {
  TimeOutException([String? message])
      : super(message, "Sorry time out ! Try again");
}

class InternetException extends CustomException {
  InternetException([String? message]) : super(message, "");
}
