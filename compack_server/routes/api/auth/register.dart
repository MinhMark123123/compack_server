import 'dart:io';
import 'package:compack_server/src/auth_service/auth_service.dart';
import 'package:compack_server/src/auth_service/exception/index.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }
  try {
    final authService = context.read<AuthService>();
    final raw = await context.request.json() as Map<String, dynamic>;
    final email = raw['email'] as String;
    final password = raw['password'] as String;
    final account = await authService.register(
      email: email,
      password: password,
    );
    return Response.json(body: account.toJson());
  } catch (e) {
    return Response(
      statusCode: HttpStatus.internalServerError,
      body: AppException.messageFromException(e),
    );
  }
}
