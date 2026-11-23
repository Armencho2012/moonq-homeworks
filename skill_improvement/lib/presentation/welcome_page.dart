import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.rocket_launch, color: Colors.blueAccent, size: 90,),

              const SizedBox(height: 20),
              const Text('Welcome!', style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.w700
              )),
              const Text('Get started with our app', style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300
              ),),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0A66FF),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Next',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
