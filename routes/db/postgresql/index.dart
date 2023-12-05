import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';
// import 'package:tasklist_backend/hash_extension.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => _getLists(context),
    HttpMethod.post => _createLists(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
  };
}

Future<Response> _getLists(RequestContext context) async {
  final list = <Map<String, dynamic>>[];
  final results = await context.read<Connection>().execute(
        'SELECT id, name FROM lists',
      );

  for (final result in results) {
    list.add({'id': result[0], 'name': result[1]});
  }
  return Response.json(body: list.toString());
}

Future<Response> _createLists(RequestContext context) async {
  final body = await context.request.json() as Map<String, dynamic>;
  final name = body['name'] as String?;
  // final id = name?.hashValue;

  if (name == null) return Response(statusCode: HttpStatus.badRequest);

  try {
    final result = await context.read<Connection>().execute(
          "INSERT INTO lists (name) VALUES ('$name')",
        );

    if (result.affectedRows == 0) {
      return Response(statusCode: HttpStatus.internalServerError);
    } else {
      final result = await context.read<Connection>().execute(
            "SELECT * FROM lists WHERE name = '$name'",
          );

      return Response.json(body: {'success': true, 'name': result[0][1]});
    }
  } catch (e) {
    return Response.json(
      body: {'success': false, 'error': e.toString()},
      statusCode: HttpStatus.connectionClosedWithoutResponse,
    );
  }
}
