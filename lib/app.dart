import 'package:flutter/material.dart';
import 'package:neurochat_ai/presentation/home/home_screen.dart';
import 'core/constants/api+constants.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Assistant App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: AppColors.secondary,
        ),
      ),
      home:   HomeScreen(),
    );
  }
}
