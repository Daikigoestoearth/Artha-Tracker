import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ArthaApp());
}

class ArthaApp extends StatelessWidget {
  const ArthaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Artha Tracker',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordObscured = true;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    setState(() {
      // Validasi email
      final email = _emailController.text;
      if (email.isEmpty) {
        _emailError = 'Email tidak boleh kosong';
      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
        _emailError = 'Format email tidak valid';
      } else {
        _emailError = null;
      }

      // Validasi password
      final password = _passwordController.text;
      if (password.isEmpty) {
        _passwordError = 'Password tidak boleh kosong';
      } else if (password.length < 8) {
        _passwordError = 'Password minimal 8 karakter';
      } else if (!RegExp(r'[a-zA-Z]').hasMatch(password) || !RegExp(r'[0-9]').hasMatch(password)) {
        _passwordError = 'Password harus mengandung huruf dan angka';
      } else if (!RegExp(r'[@#$%^&*!]').hasMatch(password)) {
        _passwordError = 'Harus ada karakter spesial (@, #, \$)';
      } else {
        _passwordError = null;
      }
    });

    if (_emailError == null && _passwordError == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login berhasil!'),
          backgroundColor: Color(0xFF143325),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF2A5846),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),

                        // LOGO KOIN EMAS
                        SizedBox(
                          width: screenWidth * 0.72,
                          height: 150,
                          child: Image.asset(
                            'assets/LogoKoinArtha.png',
                            fit: BoxFit.contain,
                          ),
                        ),

                        const SizedBox(height: 4),

                        // TEXT ARTHA
                        Text(
                          'ARTHA',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 46,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 6),

                        // SUBTITLE
                        const Text(
                          'Welcome to Artha',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Your Budget & Finance Tracker',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                          ),
                        ),

                        const SizedBox(height: 28),

                        // INPUT FIELD: EMAIL
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: _emailError != null ? Colors.red : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: TextField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(color: Colors.black87, fontSize: 16),
                                onChanged: (_) {
                                  if (_emailError != null) {
                                    setState(() => _emailError = null);
                                  }
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Email Address',
                                  hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Icon(Icons.email_outlined, color: Colors.grey, size: 24),
                                  ),
                                  prefixIconConstraints: BoxConstraints(minWidth: 40, minHeight: 40),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(vertical: 18),
                                ),
                              ),
                            ),
                            if (_emailError != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 6, left: 4),
                                child: Text(
                                  _emailError!,
                                  style: const TextStyle(color: Colors.red, fontSize: 12),
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // INPUT FIELD: PASSWORD
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: _passwordError != null ? Colors.red : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: TextField(
                                controller: _passwordController,
                                obscureText: _isPasswordObscured,
                                style: const TextStyle(color: Colors.black87, fontSize: 16),
                                onChanged: (_) {
                                  if (_passwordError != null) {
                                    setState(() => _passwordError = null);
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Icon(Icons.lock_outline, color: Colors.grey, size: 24),
                                  ),
                                  prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: IconButton(
                                      icon: Icon(
                                        _isPasswordObscured
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: Colors.grey,
                                        size: 24,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isPasswordObscured = !_isPasswordObscured;
                                        });
                                      },
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 18),
                                ),
                              ),
                            ),
                            if (_passwordError != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 6, left: 4),
                                child: Text(
                                  _passwordError!,
                                  style: const TextStyle(color: Colors.red, fontSize: 12),
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        // PASSWORD REQUIREMENTS
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Password Requirements:',
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 4),
                                Text('• Minimum 8 characters',
                                    style: TextStyle(color: Colors.white70, fontSize: 12)),
                                Text('• Include letters and numbers',
                                    style: TextStyle(color: Colors.white70, fontSize: 12)),
                                Text('• Include 1 special character (e.g., @, #, \$)',
                                    style: TextStyle(color: Colors.white70, fontSize: 12)),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // TOMBOL LOGIN
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF143325),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(27),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // FORGET PASSWORD
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: GestureDetector(
                              onTap: () {},
                              child: const Text(
                                'Forget Password?',
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),

                        const Expanded(child: SizedBox()),

                        // TEXT BAWAH: SIGN UP
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(color: Colors.white70, fontSize: 14),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}