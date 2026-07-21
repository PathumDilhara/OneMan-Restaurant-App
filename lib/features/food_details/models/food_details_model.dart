import '../../../core/models/food_size_model.dart';
import 'food_review_model.dart';

class FoodDetailsModel {
  final String id;
  final String name;
  final String slug;
  final String description;
  final int price;
  final int discountAmount;
  final String image;
  final String category;
  final String categorySlug;
  final int readyTime;
  final String tasteType;
  final bool isFeatured;
  final bool isSpecialOffer;
  final List<FoodSizeModel> sizes;
  final List<String> galleryImages;
  final List<dynamic> related;
  final List<FoodReviewModel> reviews;
  final double rating;

  FoodDetailsModel({
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
    required this.galleryImages,
    required this.related,
    required this.reviews,
    required this.rating,
  });


  factory FoodDetailsModel.fromJson(Map<String, dynamic> json) {
    return FoodDetailsModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      discountAmount: json['discount_amount'] ?? 0,
      image: json['image'] ?? '',
      category: json['category'] ?? '',
      categorySlug: json['category_slug'] ?? '',
      readyTime: json['ready_time'] ?? 0,
      tasteType: json['taste_type'] ?? '',
      isFeatured: json['is_featured'] ?? false,
      isSpecialOffer: json['is_special_offer'] ?? false,

      sizes: (json['sizes'] as List<dynamic>? ?? [])
          .map((e) => FoodSizeModel.fromJson(e))
          .toList(),

      galleryImages:
      List<String>.from(json['gallery_images'] ?? []),

      related: json['related'] ?? [],

      reviews: (json['reviews'] as List<dynamic>? ?? [])
          .map((e) => FoodReviewModel.fromJson(e))
          .toList(),

      rating: (json['rating'] ?? 0).toDouble(),
    );
  }
}


