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
      category: convertStringToCategory(stringCategory: json['category']),
      image: json['image'],
      description: json['description'] ?? "",
      rating: json['rating'],
    );
  }

  static Category convertStringToCategory({required String stringCategory}) {
    switch (stringCategory) {
      case 'electronics':
        return Category.electronics;
      case 'books':
        return Category.books;
      case 'fashion':
        return Category.fashion;
      case 'home':
        return Category.home;
      case 'mobilePhones':
        return Category.mobilePhones;
      case 'videoGames':
        return Category.videoGames;
      default:
        return Category.electronics;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'category': category.toString().split('.').last,
      'description': description,
      'rating': rating,
      'image': image,
    };
  }
}

enum Category { electronics, books, fashion, home, mobilePhones, videoGames }
