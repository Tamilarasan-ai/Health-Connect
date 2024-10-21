import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:flutter_application_1/screens/registration_screen.dart';
import 'package:flutter_application_1/screens/home_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  final AuthService _auth = AuthService();
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo at the top
              Image.asset(
                'assets/logo.png', // Ensure you have your logo asset
                height: 120,
              ),
              const SizedBox(height: 16),

              // Login Title
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
              
                ),
              ),
              const SizedBox(height: 24),

              // Form Fields
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(
                      hintText: 'Enter Email',
                      onChanged: (val) => setState(() => _email = val),
                      obscureText: false,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      hintText: 'Enter Password',
                      onChanged: (val) => setState(() => _password = val),
                      obscureText: true,
                    ),
                    const SizedBox(height: 16),

                    // Remember Me and Forgot Password Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              onChanged: (val) =>
                                  setState(() => _rememberMe = val!),
                              activeColor:  const Color(0xFFFF4615)
                            ),
                            const Text('Remember Me'),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            // Add Forgot Password logic
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(color:  Color(0xFFFF4615)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(_email, _password);
                            if (result == null) {
                              // Show error
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:  const Color(0xFFFF4615),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Log In',
                          style: TextStyle(fontSize: 18,
                          color: Colors.white),
                          
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Social Media Login Options
                    const Text(
                      'or',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSocialButton('assets/facebook.png'),
                        _buildSocialButton('assets/google.png'),
                        _buildSocialButton('assets/apple.png'),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Sign Up Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegistrationScreen(),
                            ),
                          ),
                          child: const Text(
                            'Sign up',
                            style: TextStyle(color:  Color(0xFFFF4615)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build TextFormField
  Widget _buildTextField({
    required String hintText,
    required Function(String) onChanged,
    bool obscureText = false,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      obscureText: obscureText,
      validator: (val) =>
          val!.isEmpty ? 'This field cannot be empty' : null,
      onChanged: (val) => onChanged(val),
    );
  }

  // Helper method to build social media login buttons
  Widget _buildSocialButton(String assetPath) {
    return InkWell(
      onTap: () {
        // Add social login logic
      },
      child: Image.asset(
        assetPath,
        height: 50,
        width: 50,
      ),
    );
  }
}
