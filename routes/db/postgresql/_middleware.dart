import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

Handler middleware(Handler handler) {
  return (context) async {
    final db = await Connection.open(
      Endpoint(
        host: 'localhost',
        database: 'mytasklist',
        // port: 5432,
        username: 'postgres',
        password: '123456',
      ),
      settings: ConnectionSettings(sslMode: SslMode.disable),
    );

    final response =
        await handler.use(provider<Connection>((_) => db)).call(context);

    await db.close();

    return response;
  };
}
