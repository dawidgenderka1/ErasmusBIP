import 'package:flutter/material.dart';
import 'home_page.dart'; // Make sure this file exports a class named HomePage
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
  String selectedAccountType = 'Man';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isRegistering ? 'Registration' : 'Login page'),
        backgroundColor: const Color(0xFF030154), // Blauwe AppBar
        foregroundColor: Colors.white, // Witte tekst voor AppBar titel
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: Center(
        child: Padding(
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
                    DropdownButtonFormField<String>(
                      value: selectedAccountType,
                      dropdownColor: const Color(0xFF030154),
                      decoration: _inputDecoration('Account Type'),
                      items: const [
                        DropdownMenuItem(
                          value: 'Man',
                          child: Text('Man', style: TextStyle(color: Colors.white)),
                        ),
                        DropdownMenuItem(
                          value: 'Woman',
                          child: Text('Woman', style: TextStyle(color: Colors.white)),
                        ),
                        DropdownMenuItem(
                          value: 'Child',
                          child: Text('Child', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedAccountType = value!;
                        });
                      },
                    ),
                  ],
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFffe648),
                      foregroundColor: Colors.white, // Witte tekst voor knop
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      if (!isRegistering) {
                        if(selectedAccountType=='Child'){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const ChildPage()),
                        );}
                        else{
                          Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                        );
                        }
                      } else {
                        // Obsługa rejestracji – np. zapis danych
                        if(selectedAccountType=='Child'){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const ChildPage()),
                        );}
                        else{
                          Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                        );
                        }
                      }
                    },
                    child: Text(
                      isRegistering ? 'Register' : 'Login',
                      style: const TextStyle(fontSize: 16), // Style behouden
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isRegistering = !isRegistering;
                      });
                    },
                    child: Text(
                      isRegistering ? 'You are already registered? Log in' : 'You do not have an account? Register',
                      style: const TextStyle(color: Color(0xFFFFFFFF)),
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