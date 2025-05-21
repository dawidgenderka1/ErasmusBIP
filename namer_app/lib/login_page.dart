import 'package:flutter/material.dart';
import 'home_page.dart';
import 'child_page.dart';
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isRegistering = false;
  String selectedGender = 'Man'; // MODIFIED
  int Age = 20;
  final TextEditingController ageController = TextEditingController(); // ADDED

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(isRegistering ? 'Registration' : 'Login page'),
        backgroundColor: const Color(0xFF030154),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            color: const Color(0xFF030154),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isRegistering ? 'Create an account' : 'Welcome!',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: _inputDecoration('E-mail'),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    obscureText: true,
                    decoration: _inputDecoration('Password'),
                    style: const TextStyle(color: Colors.white),
                  ),
                  if (isRegistering) ...[
                    const SizedBox(height: 16),
                    TextField(
                      obscureText: true,
                      decoration: _inputDecoration('Repeat password'),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedGender,
                            dropdownColor: const Color(0xFF030154),
                            decoration: _inputDecoration('Gender'), // MODIFIED
                            items: const [
                              DropdownMenuItem(
                                value: 'Man',
                                child: Text('Man', style: TextStyle(color: Colors.white)),
                              ),
                              DropdownMenuItem(
                                value: 'Woman',
                                child: Text('Woman', style: TextStyle(color: Colors.white)),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: ageController,
                            keyboardType: TextInputType.number,
                            decoration: _inputDecoration('Age'),
                            style: const TextStyle(color: Colors.white),
                            onChanged: (value) {
                              try {
                                Age = int.parse(value);
                              } catch (e) {
                                // Handle invalid input
                                Age = 20; // or whatever default you prefer
                              }
                            },
                            ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFffe648),
                      foregroundColor: Colors.black, // MODIFIED
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      if (Age < 15) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const ChildPage()),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                    }
                    },
                    child: Text(
                      isRegistering ? 'Register' : 'Login',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isRegistering = !isRegistering;
                      });
                    },
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                        children: isRegistering
                            ? [
                                const TextSpan(text: 'You are already registered? '),
                                const TextSpan(
                                  text: 'Log in',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white,
                                    decorationThickness: 2,
                                    color: Colors.white,
                                  ),
                                ),
                              ]
                            : [
                                const TextSpan(text: 'You do not have an account? '),
                                const TextSpan(
                                  text: 'Register',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white,
                                    decorationThickness: 2,
                                    color: Colors.white,
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
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white, width: 2),
      ),
    );
  }
}