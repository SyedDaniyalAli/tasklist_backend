import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  return switch (context.request.method) {
    HttpMethod.patch => _updateLists(context, id),
    HttpMethod.delete => _deleteLists(context, id),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
  };
}

Future<Response> _updateLists(RequestContext context, String id) async {
  final body = await context.request.json() as Map<String, dynamic>;
  final name = body['name'] as String?;

  try {
    if (name == null) return Response(statusCode: HttpStatus.badRequest);
    final result = await context
        .read<Connection>()
        .execute("UPDATE lists SET name = '$name' WHERE id = '$id'");

    if (result.affectedRows == 0) {
      return Response(statusCode: HttpStatus.internalServerError);
    } else {
      final result = await context.read<Connection>().execute(
            "SELECT * FROM lists WHERE id = '$id'",
          );

      return Response.json(body: {'success': true, 'id': result[0][0]});
    }
  } catch (e) {
    return Response.json(
      statusCode: HttpStatus.connectionClosedWithoutResponse,
      body: {'success': false, 'error': e.toString()},
    );
  }
}

Future<Response> _deleteLists(RequestContext context, String id) async {
  try {
    await context
        .read<Connection>()
        .execute("DELETE FROM lists WHERE id = '$id'");
    return Response(statusCode: HttpStatus.noContent);
  } catch (e) {
    return Response(statusCode: HttpStatus.badRequest, body: e.toString());
  }
}
