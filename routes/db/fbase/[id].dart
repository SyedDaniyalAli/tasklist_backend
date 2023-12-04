import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:firedart/firedart.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  return switch (context.request.method) {
    HttpMethod.patch => _updateList(context, id),
    HttpMethod.delete => _deleteList(context, id),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
  };
}

Future<Response> _updateList(
  RequestContext context,
  String id,
) async {
  print('await context.request.toString() ${id}');
  final body = await context.request.json() as Map<String, dynamic>;
  final name = body['name'] as String;

  await Firestore.instance
      .collection('taskList')
      .document(id)
      .update({'name': name});

  return Response.json(statusCode: HttpStatus.noContent);
}

Future<Response> _deleteList(
  RequestContext context,
  String id,
) async {
  await Firestore.instance.collection('taskList').document(id).delete().then(
    (value) {
      return Response.json(body: HttpStatus.noContent);
    },
  ).onError(
    (error, stackTrace) {
      return Response.json(body: HttpStatus.badRequest);
    },
  );

  return Response.json(body: HttpStatus.badRequest);
}
