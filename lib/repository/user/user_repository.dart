import 'package:equatable/equatable.dart';
import 'package:tasklist_backend/hash_extension.dart';

///in memory database
Map<String, dynamic> userDb = {};

///User Repository
class User extends Equatable {
  ///Constructor
  const User({
    required this.id,
    required this.userName,
    required this.name,
    required this.password,
  });

  ///User Id
  final String id;

  /// Name
  final String name;

  ///User userName
  final String userName;

  ///User Password
  final String password;

  @override
  List<Object?> get props => [
        id,
        userName,
        name,
        password,
      ];
}

/// user's repository
class UserRepository {
  ///check in the database if the user exists
  Future<User?> userCredentials(String userName, String password) async {
    final hashedPassword = password.hashValue;

    final users = userDb.values
        .where(
          (user) =>
              userName == (user as Map<String, dynamic>)['userName'] &&
              hashedPassword == user['password'].toString(),
        )
        .toList();

    if (users.isNotEmpty) {
      return users.first as User;
    }
    return null;
  }

  ///Search user by id
  User? userFromID(String id) {
    return userDb[id] as User;
  }

  ///create user
  Future<String> createUser({
    required String name,
    required String userName,
    required String password,
  }) {
    final currentUser = User(
      id: userName.hashValue,
      userName: userName,
      name: name,
      password: password.hashValue,
    );
    userDb[currentUser.id] = currentUser;

    return Future.value(currentUser.id);
  }

  ///Delete a user
  void deleteUser(String id) {
    userDb.remove(id);
  }

  ///Update a user
  void updateUser({
    required String id,
    required String name,
    required String userName,
    required String password,
  }) {
    final currentUser = userDb[id];

    if (currentUser == null) {
      throw Exception('User not found');
    }

    final user = User(
      id: id,
      userName: userName,
      name: name,
      password: password.hashValue,
    );

    userDb[id] = user;
  }
}
