import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

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
    await context.read<Db>().collection('lists').updateOne(
          where.eq('id', id),
          modify.set('name', name),
        );
    return Response(statusCode: HttpStatus.noContent); // 204
  } catch (e) {
    return Response(statusCode: HttpStatus.badRequest);
  }
}

Future<Response> _deleteLists(RequestContext context, String id) async {
  await context
      .read<Db>()
      .collection('lists')
      .deleteOne(where.eq('id', id))
      .then((value) => Response(statusCode: HttpStatus.noContent))
      .onError(
        (error, stackTrace) => Response(statusCode: HttpStatus.badRequest),
      );
  return Response(statusCode: HttpStatus.badRequest);
}
