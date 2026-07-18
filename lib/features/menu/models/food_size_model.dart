class FoodSize {
  final String label;
  final double diff;

  FoodSize({required this.label, required this.diff});

  factory FoodSize.fromJson(Map<String, dynamic> json) {
    return FoodSize(
      label: json['label'] ?? '',
      diff: (json['diff'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
