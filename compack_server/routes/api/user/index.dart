import 'dart:io';

import 'package:auth_service/auth_service.dart';
import 'package:compack_server/src/data/user_profile/models/user_profile.dart';
import 'package:compack_server/src/services/user_profile_service.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _handleGetMethod(context);
    case HttpMethod.post:
      return _handlePostMethod(context);
    case HttpMethod.delete:
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
    case HttpMethod.put:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _handlePostMethod(RequestContext context) async {
  final userProfileService = context.read<UserProfileService>();
  final user = context.read<User>();
  final raw = await context.request.json();
  final rawJson = raw as Map<String, dynamic>;
  rawJson["id"] = user.id;
  final json = UserProfile.fromJson(rawJson);
  return Response.json(
    body: await userProfileService.saveUser(user, userProfile: json),
  );
}

Future<Response> _handleGetMethod(RequestContext context) async {
  final userProfileService = context.read<UserProfileService>();
  final user = context.read<User>();
  final userResult = await userProfileService.findUserProfile(userId: user.id!);
  return Response.json(
    body: userResult?.toJson(),
  );
}
