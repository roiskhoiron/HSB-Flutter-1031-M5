import 'package:flutter/material.dart';
import '../routes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA7A7A7), // abu-abu
      body: Column(
        children: [
          // BAGIAN ATAS (LOGO)
          Expanded(
            flex: 6,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/aebbbec190680b790fb1afab99e36740075f92f4.png',
                    width: 400,
                    height: 400,
                  ),
                ],
              ),
            ),
          ),

          // BAGIAN BAWAH (CARD PUTIH)
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Keep up your Health!',
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // BUTTON PANAH
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.login);
                    },
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black),
                      ),
                      child: const Icon(Icons.arrow_forward),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}