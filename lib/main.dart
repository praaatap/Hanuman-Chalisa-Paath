import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(const HanumanChalisaPaath());
}

class HanumanChalisaPaath extends StatelessWidget {
  const HanumanChalisaPaath({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hanuman Chalisa Paath',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD97736),
          primary: const Color(0xFFD97736),
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
