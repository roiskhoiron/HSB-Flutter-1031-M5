import 'package:flutter/material.dart';
import '../routes.dart';

class HomeSplashPage extends StatelessWidget {
  const HomeSplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA7A7A7),
      body: SafeArea(
        child: Column(
          children: [
            /// ===== BAGIAN ATAS =====
            Expanded(
              flex: 7,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/checkcircle.png',
                      width: 240,
                      height: 240,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Congratss!, you are all Set!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// ===== TOMBOL BAWAH =====
            Padding(
              padding: const EdgeInsets.fromLTRB(70, 10, 70, 70),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.homePageMain,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Start Tracking',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}