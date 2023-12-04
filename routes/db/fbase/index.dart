import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:firedart/firedart.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => _getList(context),
    HttpMethod.post => _createList(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
  };
}

Future<Response> _getList(RequestContext context) async {
  final lists = <Map<String, dynamic>>[];
  await Firestore.instance.collection('taskList').get().then((event) {
    for (final doc in event) {
      lists.add(doc.map);
    }
  });

  return Response.json(body: lists.toString());
}

// {'name':'shopping'}
Future<Response> _createList(RequestContext context) async {
  // print('await context.request.toString() ${await context.request.body()}');
  final body = await context.request.json() as Map<String, dynamic>;
  final name = body['name'] as String;

  final list = <String, dynamic>{'name': name};
  final id =
      await Firestore.instance.collection('taskList').add(list).then((doc) {
    return doc.id;
  });

  return Response.json(body: {'id': id});
}
