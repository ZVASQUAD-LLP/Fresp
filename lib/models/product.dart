import 'dart:convert';
import 'dart:io';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  final String name;
  final String description;
  final String? richDescription;
  final List<String> images;
  final String brand;
  double price;
  final String? category;
  final int countInStock;
  final int? rating;
  final int? numReviews;
  final bool? isFeatured;
  final String? id;
  final DateTime? dateCreated;
  Product({
    required this.name,
    required this.description,
    this.richDescription,
    required this.images,
    required this.brand,
    required this.price,
    this.category,
    required this.countInStock,
    this.rating,
    this.numReviews,
    this.isFeatured,
    this.id,
    this.dateCreated,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'richDescription': richDescription,
      'images': images,
      'brand': brand,
      'price': price,
      'category': category,
      'countInStock': countInStock,
      'rating': rating,
      'numReviews': numReviews,
      'isFeatured': isFeatured,
      'id': id,
      // 'dateCreated': dateCreated?.millisecondsSinceEpoch,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] as String,
      description: map['description'] as String,
      richDescription: map['richDescription'] != null
          ? map['richDescription'] as String
          : null,
      images: List<String>.from((map['images'])),
      brand: map['brand'] as String,
      price: map['price'] as double,
      category: map['category'] != null ? map['category'] as String : null,
      countInStock: map['countInStock'] as int,
      rating: map['rating'] != null ? map['rating'] as int : null,
      numReviews: map['numReviews'] != null ? map['numReviews'] as int : null,
      isFeatured: map['isFeatured'] != null ? map['isFeatured'] as bool : null,
      id: map['_id'] != null ? map['_id'] as String : null,
      // dateCreated: map['dateCreated'] != null
      //     ? DateTime.fromMillisecondsSinceEpoch(map['dateCreated'] as int)
      //     : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
