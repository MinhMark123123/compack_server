import 'dart:io';

import 'package:auth_service/auth_service.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }
  try {
    final authService = context.read<AuthService>();
    final rawPostValue = await context.request.json() as Map<String, dynamic>;
    final refreshToken = rawPostValue['refresh_token'] as String;
    final tokenData = authService.decodeToken(refreshToken);
    final userId = tokenData['id'];
    final user = await authService.findUserById(userId: userId as String);
    if (user.refreshToken != refreshToken) {
      print("===> ${user.refreshToken}");
      print("===> $refreshToken");
      return Response(
        statusCode: HttpStatus.internalServerError,
        body: AppException.refreshTokenInvalid.message,
      );
    }
    final result = await authService.refreshToken(user);
    return Response.json(body: result.toJson());
  } catch (e) {
    return Response(
      statusCode: HttpStatus.internalServerError,
      body: AppException.messageFromException(e),
    );
  }
}
