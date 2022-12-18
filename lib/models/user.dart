import 'dart:convert';
import 'dart:ffi';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String id;
  final String name;
  final String number;
  final String email;
  final List<dynamic> address;
  final List<dynamic> orderHistory;
  final List<dynamic> cart;
  User({
    required this.id,
    required this.name,
    required this.number,
    required this.email,
    required this.address,
    required this.orderHistory,
    required this.cart,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'number': number,
      'email': email,
      'address': address,
      'orderHistory': orderHistory,
      'cart': cart,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['_id'] as String,
        name: map['name'] as String,
        number: map['phone'] as String,
        email: map['email'] as String,
        address: List<dynamic>.from((map['address'] as List<dynamic>)),
        orderHistory:
            List<dynamic>.from((map['orderHistory'] as List<dynamic>)),
        cart: List<Map<String, dynamic>>.from(
            map['cart']?.map((x) => Map<String, dynamic>.from(x))));
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  User copyWith({
    String? id,
    String? name,
    String? number,
    String? email,
    List<dynamic>? address,
    List<dynamic>? orderHistory,
    List<dynamic>? cart,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      number: number ?? this.number,
      email: email ?? this.email,
      address: address ?? this.address,
      orderHistory: orderHistory ?? this.orderHistory,
      cart: cart ?? this.cart,
    );
  }
}
