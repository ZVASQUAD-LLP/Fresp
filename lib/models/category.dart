import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CategoryList {
  final String? id;
  final String name;
  // final String icon;
  CategoryList({
    this.id,
    required this.name,
    // required this.icon,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      // 'icon': icon,
    };
  }

  factory CategoryList.fromMap(Map<String, dynamic> map) {
    return CategoryList(
      id: map['_id'] != null ? map['_id'] as String : null,
      name: map['name'] as String,
      // icon: map['icon'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryList.fromJson(String source) =>
      CategoryList.fromMap(json.decode(source) as Map<String, dynamic>);
}
