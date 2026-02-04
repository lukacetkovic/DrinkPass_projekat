import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Login'),
              ),
            ),

            const SizedBox(height: 16),

            TextButton(
              onPressed: () {},
              child: const Text('Create new account'),
            ),
          ],
        ),
      ),
    );
  }
}