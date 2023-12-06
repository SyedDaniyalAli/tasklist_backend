import 'package:dart_frog/dart_frog.dart';
import 'package:mysql_client/mysql_client.dart';

Handler middleware(Handler handler) {
  return (context) async {
    final conn = await MySQLConnection.createConnection(
      host: '0.0.0.0',
      port: 3306,
      userName: 'root',
      password: '12345678',
      databaseName: 'employee_db', // optional
    );

    // actually connect to database
    await conn.connect();

    final response =
        await handler.use(provider<MySQLConnection>((_) => conn)).call(
              context,
            );

    await conn.close();

    return response;
  };
}
