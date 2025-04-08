import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commercy/core/utils/strings.dart';

class ProductModel {
  final String image;
  final String title;
  final String description;
  final num price;
  final num? rating;
  final Category category;
  Timestamp? date;

  static int productsNumber = 0;
  ProductModel({
    this.date,
    required this.title,
    this.description = '',
    required this.price,
    this.rating,
    required this.category,
    required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      title: json['title'],
      price: json['price'],
      category: Category.fromString(stringCategory: json[Strings.category])!,
      image: json['image'],
      description: json['description'] ?? "",
      rating: json['rating'],
      date: json['date'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'category': category.toString().split('.').last,
      'description': description,
      'image': image,
      'date': date,
    };
  }
}

enum Category {
  electronics,
  books,
  fashion,
  home,
  mobilePhones,
  videoGames;

  static Category? fromString({required String stringCategory}) {
    for (var value in Category.values) {
      if (value.name == stringCategory) return value;
    }
    return null;
  }
}
