import 'package:flutter/material.dart';
import '../routes.dart';
import '../theme/app_color.dart';
import '../theme/app_text.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String gender = 'Female';

  final BorderRadius _radius = BorderRadius.circular(12);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
      isDark ? AppColor.darkBackground : AppColor.lightBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const SizedBox(height: 2),

              /// ===== LOGO =====
              Column(
                children: [
                  Image.asset(
                    'assets/images/aebbbec190680b790fb1afab99e36740075f92f4.png',
                    width: 200,
                  ),
                ],
              ),

              const SizedBox(height: 4),

              /// ===== FORM CARD =====
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColor.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Account Register',
                          style: AppText.title(context)
                              .copyWith(color: AppColor.white),
                        ),
                      ),

                      const SizedBox(height: 20),

                      _label(context, 'Full Name'),
                      InputField(),

                      _label(context, 'Email'),
                      InputField(),

                      _label(context, 'Gender'),
                      _genderDropdown(),

                      _label(context, 'Mobile'),
                      Row(
                        children: [
                          _CountryCode(radius: _radius),
                          const SizedBox(width: 8),
                          Expanded(child: InputField()),
                        ],
                      ),

                      _label(context, 'Password'),
                      InputField(obscure: true, isPassword: true),

                      _label(context, 'Confirm Password'),
                      InputField(obscure: true, isPassword: true),

                      const SizedBox(height: 12),

                      Container(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: (){}, ///Belum ada Navigasi
                        child: Text(
                          'Forgot Password?',
                          style: AppText.caption(context)
                              .copyWith(color: AppColor.grey.shade300),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      /// REGISTER BUTTON
                      _PrimaryButton(
                        text: 'Register',
                        color: AppColor.primary,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.home);
                          }
                        },
                      ),

                      const SizedBox(height: 16),

                      /// LOGIN BUTTON
                      _PrimaryButton(
                        text: 'Login',
                        color: const Color(0xFFE2FCD9),
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.login);
                        },
                      ),

                      const SizedBox(height: 20),

                      /// OR
                      Row(
                        children: [
                          Expanded(
                            child: Divider(color: AppColor.white),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'Or',
                              style: AppText.caption(context)
                                  .copyWith(color: AppColor.grey),
                            ),
                          ),
                          Expanded(
                            child: Divider(color: AppColor.white),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      /// GOOGLE BUTTON
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, AppRoutes.home);
                          },
                          icon: const Icon(
                            Icons.g_mobiledata,
                            size: 28,
                            color: AppColor.white,
                          ),
                          label: Text(
                            'Sign in with Google',
                            style: AppText.body(context).copyWith(color: AppColor.white),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColor.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            alignment: Alignment.center, // ⬅️ ini opsional tapi rapi
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ===== COMPONENTS =====

  Widget _label(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: RichText(
        text: TextSpan(
          text: text,
          style:
          AppText.caption(context).copyWith(color: AppColor.white),
          children: const [
            TextSpan(
              text: ' *',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _input({bool obscure = false, bool isPassword = false}) {
  //   return TextFormField(
  //     obscureText: obscure,
  //     validator: (v) => v == null || v.isEmpty ? 'Required' : null,
  //     decoration: InputDecoration(
  //       filled: true,
  //       fillColor: AppColor.white,
  //       border: OutlineInputBorder(
  //         borderRadius: _radius,
  //         borderSide: BorderSide.none,
  //       ),
  //     ),
  //   );
  // }

  Widget _input({
    bool obscure = false,
    bool isPassword = false, // default false, biar form lama aman
  }) {
    if (isPassword) {
      // Password field dengan show/hide
      return StatefulBuilder(
        builder: (context, setState) {
          bool _obscureText = obscure;
          return TextFormField(
            obscureText: _obscureText,
            validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColor.white,
              border: OutlineInputBorder(
                borderRadius: _radius,
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
          );
        },
      );
    } else {
      // Field biasa, tetap kompatibel dengan form lama
      return TextFormField(
        obscureText: obscure,
        validator: (v) => v == null || v.isEmpty ? 'Required' : null,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColor.white,
          border: OutlineInputBorder(
            borderRadius: _radius,
            borderSide: BorderSide.none,
          ),
        ),
      );
    }
  }

  Widget _genderDropdown() {
    return DropdownButtonFormField<String>(
      value: gender,
      items: const [
        DropdownMenuItem(value: 'Female', child: Text('Female')),
        DropdownMenuItem(value: 'Male', child: Text('Male')),
      ],
      onChanged: (v) => setState(() => gender = v!),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColor.white,
        border: OutlineInputBorder(
          borderRadius: _radius,
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

/// ===== SMALL WIDGETS =====

class _CountryCode extends StatelessWidget {
  final BorderRadius radius;

  const _CountryCode({required this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: radius,
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('🇮🇩', style: TextStyle(fontSize: 16)),
          SizedBox(width: 4),
          Text('+62', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool outlined;
  final FontWeight? fontWeight;
  final Color? color;

  const _PrimaryButton({
    required this.text,
    required this.onPressed,
    this.outlined = false,
    this.fontWeight,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: outlined
          ? OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColor.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding:
          const EdgeInsets.symmetric(vertical: 14),
        ),
        child: Text(
          text,
          style: AppText.body(context)
              .copyWith(color: AppColor.white),
        ),
      )
          : ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColor.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding:
          const EdgeInsets.symmetric(vertical: 14),
        ),
        child: Text(
          text,
          style: AppText.body(context)
              .copyWith(color: AppColor.white),
        ),
      ),
    );
  }
}


class InputField extends StatefulWidget {
  final bool obscure;
  final bool isPassword;
  final TextEditingController? controller;

  const InputField({
    super.key,
    this.obscure = false,
    this.isPassword = false,
    this.controller,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscureText : false,
      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white, // ganti sesuai AppColor.white
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        )
            : null,
      ),
    );
  }
}