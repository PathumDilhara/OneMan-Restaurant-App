import 'package:oneman/core/network/api_constants.dart';

class CategoryModel {
  final int id;
  final String name;
  final String slug;
  final String parentId;
  final String image;
  final String description;
  final bool isActive;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.parentId,
    required this.image,
    required this.description,
    required this.isActive,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: (json["id"] as num?)?.toInt() ?? 0,
      name: json["name"] ?? "",
      slug: json["slug"] ?? "",
      parentId: json["parentId"] ?? "",
      image: ApiConstants.imageUrl(json["image"]),
      description: json["description"] ?? "",
      isActive: json["isActive"] ?? false,
    );
  }
}
