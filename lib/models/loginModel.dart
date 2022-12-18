import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginModel {
  final String id;
  final String name;
  final String number;
  final String token;
  final String email;
  final String password;
  final List<dynamic> address;
  final List<dynamic> orderHistory;
  LoginModel({
    required this.id,
    required this.name,
    required this.number,
    required this.token,
    required this.email,
    required this.password,
    required this.address,
    required this.orderHistory,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'number': number,
      'token': token,
      'email': email,
      'password': password,
      'address': address,
      'orderHistory': orderHistory,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      id: map['id'] as String,
      name: map['name'] as String,
      number: map['number'] as String,
      token: map['token'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      address: List<dynamic>.from((map['address'] as List<dynamic>)),
      orderHistory: List<dynamic>.from((map['orderHistory'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) =>
      LoginModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
