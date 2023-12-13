import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:tasklist_backend/hash_extension.dart';

/// A session database
@visibleForTesting
Map<String, Session> sessionDB = {};

/// A session model
class Session extends Equatable {
  // final String? role;

  /// The constructor
  const Session({
    required this.userId,
    this.token,
    this.expiryDate,
    this.createdDate,
  });

  /// The session user id
  final String userId;

  /// The session token
  final String? token;

  /// The session expiry date
  final DateTime? expiryDate;

  /// The session created date
  final DateTime? createdDate;

  @override
  List<Object?> get props => [
        userId,
        token,
        expiryDate,
        createdDate,
      ];
}

/// A session repository
class SessionRepository {
  /// create session
  Session createSession(String userID) {
    final session = Session(
      userId: userID,
      token: generateToken(userID),
      expiryDate: DateTime.now().add(const Duration(days: 1)),
      createdDate: DateTime.now(),
    );

    sessionDB[session.token!] = session;

    return session;
  }

  ///generate token
  String generateToken(String userID) {
    return '${userID}_${DateTime.now().toIso8601String()}'.hashValue;
  }

  ///Search a session of particular token
  Session? sessionFromToken(String token) {
    final session = sessionDB[token];
    if (session != null && session.expiryDate!.isAfter(DateTime.now())) {
      return session;
    } else {
      return null;
    }
  }
}
