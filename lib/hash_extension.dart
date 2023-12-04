import 'dart:convert';

import 'package:crypto/crypto.dart';

/// Add hash functionality to a string
extension HashStringExtension on String {
  /// Returns sha256 hash of this[String]
  String get hashValue {
    return sha256.convert(utf8.encode(this)).toString();
  }
}
