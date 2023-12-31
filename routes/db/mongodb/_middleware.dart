import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

Handler middleware(Handler handler) {
  return (context) async {
    final db = await Db.create(
        'mongodb+srv://razamerchant:0roHYf4zQxgY1PYt@cluster0.tjnqh6a.mongodb.net/?retryWrites=true&w=majority');
    if (!db.isConnected) {
      await db.open();
    }
    final response = await handler.use(provider<Db>((_) => db)).call(context);

    await db.close();

    return response;
  };
}
