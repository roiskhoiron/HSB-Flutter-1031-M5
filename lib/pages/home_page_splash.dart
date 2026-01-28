import 'package:flutter/material.dart';
import '../routes.dart';

class HomeSplashPage extends StatelessWidget {
  const HomeSplashPage({super.key});

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
                children: const [
                  Icon(
                    Icons.link, // placeholder logo
                    size: 80,
                    color: Colors.green,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Habitly',
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
                    'Congratss!, you are all Set!',
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