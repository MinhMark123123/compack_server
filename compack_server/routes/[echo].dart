import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context, String echo) {
  return Response(body: echo);
}
