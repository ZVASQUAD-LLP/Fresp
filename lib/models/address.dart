import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Address {
  final String street;
  final String apartment;
  final String zip;
  final String city;
  final String? id;

  Address(
    this.street,
    this.apartment,
    this.zip,
    this.city,
    this.id,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'street': street,
      'apartment': apartment,
      'zip': zip,
      'city': city,
      'id': id,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      map['street'] as String,
      map['apartment'] as String,
      map['zip'] as String,
      map['city'] as String,
      map['_id'] != null ? map['_id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Address(street: $street, apartment: $apartment, zip: $zip, city: $city, id: $id)';
  }
}
