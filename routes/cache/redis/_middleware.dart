import 'package:dart_frog/dart_frog.dart';
import 'package:redis/redis.dart';

String? _greeting;

Handler middleware(Handler handler) {
  final conn = RedisConnection();
  return (context) async {
    Response response;
    try {
      final command = await conn.connect('localhost', 6379);
      try {
        await command.send_object(['AUTH', 'default', 'picker-redis']);
        response =
            await handler.use(provider<Command>((_) => command)).call(context);
      } catch (e) {
        response = Response.json(
          body: {
            'success': false,
            'message': 'Redis connection failed',
          },
        );
      }
    } catch (e) {
      response = Response.json(
        body: {
          'success': false,
          'message': 'Redis connection failed',
        },
      );
    }

    await conn.close();

    return response;
  };
}
