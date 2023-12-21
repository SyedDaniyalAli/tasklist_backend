// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, implicit_dynamic_list_literal

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';


import '../routes/ws.dart' as ws;
import '../routes/index.dart' as index;
import '../routes/lists/index.dart' as lists_index;
import '../routes/items/index.dart' as items_index;
import '../routes/db/postgresql/index.dart' as db_postgresql_index;
import '../routes/db/postgresql/[id].dart' as db_postgresql_$id;
import '../routes/db/mysql/index.dart' as db_mysql_index;
import '../routes/db/mysql/[id].dart' as db_mysql_$id;
import '../routes/db/mongodb/index.dart' as db_mongodb_index;
import '../routes/db/mongodb/[id].dart' as db_mongodb_$id;
import '../routes/db/fbase/index.dart' as db_fbase_index;
import '../routes/db/fbase/[id].dart' as db_fbase_$id;
import '../routes/cache/redis/index.dart' as cache_redis_index;
import '../routes/authentication/bearer/index.dart' as authentication_bearer_index;
import '../routes/authentication/bearer/[id].dart' as authentication_bearer_$id;
import '../routes/authentication/basic/index.dart' as authentication_basic_index;
import '../routes/authentication/basic/[id].dart' as authentication_basic_$id;
import '../routes/api/rest_api/index.dart' as api_rest_api_index;

import '../routes/_middleware.dart' as middleware;
import '../routes/db/postgresql/_middleware.dart' as db_postgresql_middleware;
import '../routes/db/mysql/_middleware.dart' as db_mysql_middleware;
import '../routes/db/mongodb/_middleware.dart' as db_mongodb_middleware;
import '../routes/db/fbase/_middleware.dart' as db_fbase_middleware;
import '../routes/cache/redis/_middleware.dart' as cache_redis_middleware;
import '../routes/authentication/bearer/_middleware.dart' as authentication_bearer_middleware;
import '../routes/authentication/basic/_middleware.dart' as authentication_basic_middleware;
import '../routes/api/rest_api/_middleware.dart' as api_rest_api_middleware;

void main() async {
  final address = InternetAddress.anyIPv6;
  final port = int.tryParse(Platform.environment['PORT'] ?? '8080') ?? 8080;
  createServer(address, port);
}

Future<HttpServer> createServer(InternetAddress address, int port) async {
  final handler = Cascade().add(buildRootHandler()).handler;
  final server = await serve(handler, address, port);
  print('\x1B[92m✓\x1B[0m Running on http://${server.address.host}:${server.port}');
  return server;
}

Handler buildRootHandler() {
  final pipeline = const Pipeline().addMiddleware(middleware.middleware);
  final router = Router()
    ..mount('/api/rest_api', (context) => buildApiRestApiHandler()(context))
    ..mount('/authentication/basic', (context) => buildAuthenticationBasicHandler()(context))
    ..mount('/authentication/bearer', (context) => buildAuthenticationBearerHandler()(context))
    ..mount('/cache/redis', (context) => buildCacheRedisHandler()(context))
    ..mount('/db/fbase', (context) => buildDbFbaseHandler()(context))
    ..mount('/db/mongodb', (context) => buildDbMongodbHandler()(context))
    ..mount('/db/mysql', (context) => buildDbMysqlHandler()(context))
    ..mount('/db/postgresql', (context) => buildDbPostgresqlHandler()(context))
    ..mount('/items', (context) => buildItemsHandler()(context))
    ..mount('/lists', (context) => buildListsHandler()(context))
    ..mount('/', (context) => buildHandler()(context));
  return pipeline.addHandler(router);
}

Handler buildApiRestApiHandler() {
  final pipeline = const Pipeline().addMiddleware(api_rest_api_middleware.middleware);
  final router = Router()
    ..all('/', (context) => api_rest_api_index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildAuthenticationBasicHandler() {
  final pipeline = const Pipeline().addMiddleware(authentication_basic_middleware.middleware);
  final router = Router()
    ..all('/', (context) => authentication_basic_index.onRequest(context,))..all('/<id>', (context,id,) => authentication_basic_$id.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildAuthenticationBearerHandler() {
  final pipeline = const Pipeline().addMiddleware(authentication_bearer_middleware.middleware);
  final router = Router()
    ..all('/', (context) => authentication_bearer_index.onRequest(context,))..all('/<id>', (context,id,) => authentication_bearer_$id.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildCacheRedisHandler() {
  final pipeline = const Pipeline().addMiddleware(cache_redis_middleware.middleware);
  final router = Router()
    ..all('/', (context) => cache_redis_index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildDbFbaseHandler() {
  final pipeline = const Pipeline().addMiddleware(db_fbase_middleware.middleware);
  final router = Router()
    ..all('/', (context) => db_fbase_index.onRequest(context,))..all('/<id>', (context,id,) => db_fbase_$id.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildDbMongodbHandler() {
  final pipeline = const Pipeline().addMiddleware(db_mongodb_middleware.middleware);
  final router = Router()
    ..all('/', (context) => db_mongodb_index.onRequest(context,))..all('/<id>', (context,id,) => db_mongodb_$id.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildDbMysqlHandler() {
  final pipeline = const Pipeline().addMiddleware(db_mysql_middleware.middleware);
  final router = Router()
    ..all('/', (context) => db_mysql_index.onRequest(context,))..all('/<id>', (context,id,) => db_mysql_$id.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildDbPostgresqlHandler() {
  final pipeline = const Pipeline().addMiddleware(db_postgresql_middleware.middleware);
  final router = Router()
    ..all('/', (context) => db_postgresql_index.onRequest(context,))..all('/<id>', (context,id,) => db_postgresql_$id.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildItemsHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => items_index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildListsHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => lists_index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/ws', (context) => ws.onRequest(context,))..all('/', (context) => index.onRequest(context,));
  return pipeline.addHandler(router);
}

