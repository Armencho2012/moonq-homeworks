import 'package:flutter/material.dart';
import 'package:skill_improvement/presentation/welcome_page.dart';

class WelcomePageBase extends StatelessWidget {
  const WelcomePageBase({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      home: const WelcomePage(),
    );
  }
}