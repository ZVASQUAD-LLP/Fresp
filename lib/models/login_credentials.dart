// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginCredentials {
  final String email;
  final String token;
  final bool isAdmin;
  LoginCredentials({
    required this.email,
    required this.token,
    required this.isAdmin,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'token': token,
      'isAdmin': isAdmin,
    };
  }

  factory LoginCredentials.fromMap(Map<String, dynamic> map) {
    return LoginCredentials(
      email: map['email'] as String,
      token: map['token'] as String,
      isAdmin: map['isAdmin'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginCredentials.fromJson(String source) =>
      LoginCredentials.fromMap(json.decode(source) as Map<String, dynamic>);
}
