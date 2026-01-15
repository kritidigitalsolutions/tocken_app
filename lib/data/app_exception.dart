// lib/utils/app_exception.dart

class AppException implements Exception {
  final String message;
  final String? prefix;
  final int? statusCode;

  AppException(this.message, {this.prefix, this.statusCode});

  @override
  String toString() {
    return "${prefix ?? ''}$message";
  }
}

/* ----------- API Exceptions ----------- */

class FetchDataException extends AppException {
  FetchDataException(super.message, {super.statusCode})
    : super(prefix: "Error: ");
}

class BadRequestException extends AppException {
  BadRequestException(super.message, {super.statusCode})
    : super(prefix: "Invalid Request: ");
}

class UnauthorizedException extends AppException {
  UnauthorizedException(super.message, {super.statusCode})
    : super(prefix: "Unauthorized: ");
}

class ForbiddenException extends AppException {
  ForbiddenException(super.message, {super.statusCode})
    : super(prefix: "Forbidden: ");
}

class NotFoundException extends AppException {
  NotFoundException(super.message, {super.statusCode})
    : super(prefix: "Not Found: ");
}

class InternalServerException extends AppException {
  InternalServerException(super.message, {super.statusCode})
    : super(prefix: "Server Error: ");
}

class NoInternetException extends AppException {
  NoInternetException()
    : super("No Internet Connection", prefix: "Network Error: ");
}
