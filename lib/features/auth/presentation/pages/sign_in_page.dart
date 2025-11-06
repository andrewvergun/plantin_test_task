import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plantin_test_task/common/widgets/common_filled_button.dart';
import 'package:plantin_test_task/common/widgets/common_text_field.dart';
import 'package:plantin_test_task/features/auth/presentation/pages/sign_up_page.dart';

import '../../data/services/auth_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  static const path = 'signin';

  @override
  State<SignInPage> createState() => _SignInPageState();


}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign in'), centerTitle: true),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 16),
              CommonTextField(
                labelText: 'Email',
                controller: _emailController,
                hintText: 'Enter email',
                validator: (value) {
                  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(value!)) {
                    return 'Please enter a valid email';
                  }
                  ;
                },
                isPassword: false,
              ),
              SizedBox(height: 16),
              CommonTextField(
                labelText: 'Password',
                controller: _passwordController,
                hintText: 'Enter password',
                validator: (value) {
                  if (value!.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                },
                isPassword: true,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CommonFilledButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          try {
                            AuthService().signInWithEmailAndPassword(
                              _emailController.text,
                              _passwordController.text,
                            );
                          } on FirebaseAuthException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Authentication error: $e')),
                            );
                          }
                        }
                      },
                      text: 'Sign in',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CommonFilledButton(
                      onPressed: () {
                        context.goNamed(SignUpPage.path);
                      },
                      text: 'Go to Sign up',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
