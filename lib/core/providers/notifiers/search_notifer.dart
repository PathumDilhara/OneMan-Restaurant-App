import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchNotifier extends Notifier<String>{

  @override
  String build() {
    return "";
  }

  void clear(){
    state = "";
  }

  void search (String value){
    state = value.trim();
  }
}