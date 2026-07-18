class FoodReviewModel {
  final int id;
  final String author;
  final int rating;
  final String date;
  final String comment;

  FoodReviewModel({
    required this.id,
    required this.author,
    required this.rating,
    required this.date,
    required this.comment,
  });


  factory FoodReviewModel.fromJson(Map<String, dynamic> json) {
    return FoodReviewModel(
      id: json['id'] ?? 0,
      author: json['author'] ?? '',
      rating: json['rating'] ?? 0,
      date: json['date'] ?? '',
      comment: json['comment'] ?? '',
    );
  }
}