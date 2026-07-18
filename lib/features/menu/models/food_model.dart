import 'food_size_model.dart';

class FoodModel {
  final String id;
  final String name;
  final String slug;
  final String description;
  final double price;
  final double discountAmount;
  final String image;
  final String category;
  final String categorySlug;
  final int readyTime;
  final String tasteType;
  final bool isFeatured;
  final bool isSpecialOffer;
  final List<FoodSize> sizes;
  final double rating;

  FoodModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.price,
    required this.discountAmount,
    required this.image,
    required this.category,
    required this.categorySlug,
    required this.readyTime,
    required this.tasteType,
    required this.isFeatured,
    required this.isSpecialOffer,
    required this.sizes,
    required this.rating,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discountAmount: (json['discount_amount'] as num?)?.toDouble()??0.0,
      image: json['image'] ?? '',
      category: json['category'] ?? '',
      categorySlug: json['category_slug'] ?? '',
      readyTime: json['ready_time'] ?? 0,
      tasteType: json['taste_type'] ?? '',
      isFeatured: json['is_featured'] ?? false,
      isSpecialOffer: json['is_special_offer'] ?? false,
      sizes:
          (json['sizes'] as List<dynamic>)
              .map((e) => FoodSize.fromJson(e))
              .toList(),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
