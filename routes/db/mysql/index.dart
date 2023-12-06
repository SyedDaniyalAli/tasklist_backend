import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mysql_client/mysql_client.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => _getLists(context),
    HttpMethod.post => _createLists(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
  };
}

Future<Response> _getLists(RequestContext context) async {
  final list = <Map<String, dynamic>>[];
  final results = await context.read<MySQLConnection>().execute(
        'SELECT id, name FROM lists',
      );

  for (final element in results.rows) {
    list.add(element.assoc());
  }

  return Response.json(body: list.toString());
}

Future<Response> _createLists(RequestContext context) async {
  final body = await context.request.json() as Map<String, dynamic>;
  final name = body['name'] as String?;

  if (name == null) return Response(statusCode: HttpStatus.badRequest);

  try {
    final result = await context.read<MySQLConnection>().execute(
          "INSERT INTO lists (name) VALUES ('$name')",
        );

    if (result.affectedRows == BigInt.zero) {
      return Response(statusCode: HttpStatus.internalServerError);
    } else {
      final result = await context.read<MySQLConnection>().execute(
            "SELECT * FROM lists WHERE name = '$name'",
          );

      return Response.json(
        body: {
          'success': true,
          'Data': result.rows.last.assoc(),
        },
      );
    }
  } catch (e) {
    return Response.json(
      body: {'success': false, 'error': e.toString()},
      statusCode: HttpStatus.connectionClosedWithoutResponse,
    );
  }
}
