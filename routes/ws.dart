import 'dart:developer';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';

Future<Handler> onRequest(RequestContext context) async {
  log('WebSocket request received');
  final handler = webSocketHandler((channel, protocol) {
    channel.stream.listen(
      (message) {
        log('WebSocket message received: $message');
        channel.sink.add(message);
      },
      onDone: () {
        log('WebSocket channel closed');
      },
    );
  });
  return handler;
}
