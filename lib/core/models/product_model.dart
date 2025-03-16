class ProductModel {
  final String image;
  final String title;
  final String? description;
  final double price;
  final double? rating;
  final Category category;
  ProductModel({
    required this.title,
    this.description,
    required this.price,
    this.rating,
    required this.category,
    required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      title: json['title'],
      price: json['price'],
      category: json['category'],
      image: json['image'],
      description: json['description'] ?? "",
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'category': category,
      'description': description,
      'rating': rating,
      'image': image,
    };
  }
}

enum Category { electronics, books, fashion, home, mobilePhones, videoGames }
