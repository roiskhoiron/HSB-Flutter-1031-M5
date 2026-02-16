import 'package:flutter/material.dart';
import '../routes.dart';
import '../theme/app_color.dart';
import '../theme/app_text.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor:
      isDark ? AppColor.darkBackground : AppColor.lightBackground,
      body: SafeArea(
        child: Column(
          children: [
            /// ===== TOP SECTION (LOGO) =====
            Expanded(
              flex: 6,
              child: Center(
                child: Image.asset(
                  'assets/images/aebbbec190680b790fb1afab99e36740075f92f4.png',
                  width: size.width * 0.8,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            /// ===== BOTTOM CARD =====
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 40,
                ),
                decoration: const BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Keep up your Health!',
                      textAlign: TextAlign.center,
                      style: AppText.body(context).copyWith(
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 36),

                    /// BUTTON NEXT
                    InkWell(
                      borderRadius: BorderRadius.circular(28),
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.login,
                        );
                      },
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColor.black,
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: AppColor.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}