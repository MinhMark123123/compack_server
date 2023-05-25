import 'dart:io';

enum AppException implements Exception {
  unauthorized(code: HttpStatus.unauthorized, message: 'Unauthorized'),
  tokenExpried(code: HttpStatus.unauthorized, message: 'Token Expired'),
  tokenInvalid(code: HttpStatus.unauthorized, message: 'Password Invalid'),
  noUserFounded(code: HttpStatus.unauthorized, message: 'No user founded'),
  passwordNotMatch(
    code: HttpStatus.unauthorized,
    message: 'Password not matched',
  ),
  emailInvalid(code: HttpStatus.internalServerError, message: 'Email Invalid'),
  passwordInvalid(
    code: HttpStatus.internalServerError,
    message: 'Password Invalid',
  );

  const AppException({
    required this.code,
    required this.message,
  });

  final int code;
  final String message;
  static String messageFromException(dynamic e){
    if(e is List<AppException>){
      return e.map((e) => e.message).join(',');
    }
    if(e is AppException){
      return e.message;
    }
    print(e);
    return 'Ops! Unknow Error';
  }
}