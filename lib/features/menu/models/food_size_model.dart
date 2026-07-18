class FoodSizeModel {
  final String label;
  final double diff;

  FoodSizeModel({required this.label, required this.diff});

  factory FoodSizeModel.fromJson(Map<String, dynamic> json) {
    return FoodSizeModel(
      label: json['label'] ?? '',
      diff: (json['diff'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
