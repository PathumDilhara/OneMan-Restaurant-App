import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneman/core/utils/app_theme.dart';
import 'package:oneman/features/menu/screens/menu_screen.dart';

void main(){
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Oneman",
      theme: AppTheme.lightTheme,
      home: MenuScreen(),
    );
  }
}
