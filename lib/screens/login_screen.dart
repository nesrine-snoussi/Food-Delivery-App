// Login Screen
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      await AuthService().loginUser(
        emailController.text,
        passwordController.text,
      );
      // Navigate to home screen after successful login
      Navigator.pushReplacementNamed(context, '/logged_in');
    } catch (e) {
      print('Error during login: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white70,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white60,
                    offset: Offset(0, 4),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/pizza-1.png',
                  width: 60,
                  height: 60,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Welcome to PizzaTime !',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Please Login to continue !',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            OutlinedButton(
              onPressed: _login,
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 36),

                backgroundColor: Colors.blue,  // Set button background color
                side: BorderSide(color: Colors.blue),
                // Make button width equal to TextField width
              ),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
