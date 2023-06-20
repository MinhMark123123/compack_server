import 'dart:io';
import 'package:compack_server/src/data/user_profile/models/user_profile.dart';
import 'package:compack_server/src/services/user_profile_service.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _handleGetMethod(context, id);
    case HttpMethod.put:
      return _handlePutMethod(context, id);
    case HttpMethod.delete:
    case HttpMethod.post:
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _handlePutMethod(RequestContext context, String id) async {
  final userProfileService = context.read<UserProfileService>();
  final request = context.request.json() as Map<String, dynamic>;
  request['id'] = id;
  final userProfileUpdated = await userProfileService.updateUserProfile(
    userProfile: UserProfile.fromJson(request),
  );
  return Response.json(body: userProfileUpdated?.toJson());
}

Future<Response> _handleGetMethod(RequestContext context, String id) async {
  final userProfileService = context.read<UserProfileService>();
  return Response.json(
    body: await userProfileService.findUserProfile(userId: id),
  );
}
