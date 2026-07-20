import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriceFilterNotifier extends Notifier<double> {
  @override
  double build() {
    return 0.0;
  }

  void handleValue(double price){
    state = price;
  }
}