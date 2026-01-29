import 'package:flutter/material.dart';
import 'package:mission_5_habbits/routes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String gender = 'Female';

  final BorderRadius _radius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA7A7A7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              /// ===== LOGO =====
              Column(
                children: const [
                  Icon(
                    Icons.link,
                    size: 64,
                    color: Color(0xFF2FB969),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Habitly',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// ===== FORM CARD =====
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Account Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      _label('Full Name'),
                      _input(),

                      _label('Email'),
                      _input(),

                      _label('Jenis Kelamin'),
                      _genderDropdown(),

                      _label('Mobile'),
                      Row(
                        children: [
                          _CountryCode(),
                          const SizedBox(width: 8),
                          Expanded(child: _input()),
                        ],
                      ),

                      _label('Password'),
                      _input(obscure: true),

                      _label('Confirm Password'),
                      _input(obscure: true),

                      const SizedBox(height: 10),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey.shade300),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// REGISTER BUTTON
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2FB969), // hijau
                            foregroundColor: Colors.white, // teks putih
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: _radius,
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushReplacementNamed(context, AppRoutes.home);
                            }
                          },
                          child: const Text('Register'),
                        ),
                      ),

                      const SizedBox(height: 18),

                      /// LOGIN BUTTON
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Color(0xFF42A5F5),
                            // warna teks
                            side: BorderSide(color: Color(0xFF81C784)),
                            // border hijau soft
                            backgroundColor: Color(0xFF81C784),
                            // background hijau tipis
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: _radius,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: const Text('Login'),
                        ),
                      ),

                      const SizedBox(height: 18),

                      /// OR
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: Divider(
                                color: Colors.white, // garis putih
                                thickness: 1.5, // tebal garis
                              ),
                            ),
                          ),
                          const Text(
                            'Or',
                            style: TextStyle(color: Colors.white),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 8),
                              child: Divider(
                                color: Colors.white, // garis putih
                                thickness: 1.5, // tebal garis
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      /// GOOGLE BUTTON
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          icon: const Icon(
                            Icons.g_mobiledata,
                            size: 28,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Sign in with Google',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: _radius,
                            ),
                            foregroundColor: Colors.white, // ikon & teks saat ditekan
                            // overlayColor harus pakai MaterialStateProperty
                          ).copyWith(
                            overlayColor: WidgetStateProperty.all(Colors.white.withOpacity(0.1)),
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, AppRoutes.home);
                          },
                        ),
                      ),
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

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 6),
      child: RichText(
        text: TextSpan(
          text: text,
          style: const TextStyle(color: Colors.white),
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

  Widget _input({bool obscure = false}) {
    return TextFormField(
      obscureText: obscure,
      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: _radius,
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _genderDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: gender,
      items: const [
        DropdownMenuItem(value: 'Female', child: Text('Female')),
        DropdownMenuItem(value: 'Male', child: Text('Male')),
      ],
      onChanged: (v) => setState(() => gender = v!),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: _radius,
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _CountryCode() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: _radius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text('🇮🇩', style: TextStyle(fontSize: 16)), // bendera
          SizedBox(width: 4),
          Text('+62', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}