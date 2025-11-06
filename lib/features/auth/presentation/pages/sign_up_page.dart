import 'package:flutter/material.dart';
import 'package:plantin_test_task/common/widgets/common_filled_button.dart';
import 'package:plantin_test_task/common/widgets/common_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign up'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 16),
              CommonTextField(
                labelText: 'Email',
                isPassword: false,
                controller: _emailController,
                hintText: 'Enter email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  final emailRegex = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );
                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                },
              ),
              SizedBox(height: 16),
              CommonTextField(
                labelText: 'Password',
                isPassword: true,
                controller: _passwordController,
                hintText: 'Enter password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }

                  return null;
                },
              ),
              SizedBox(height: 16),
              CommonTextField(
                labelText: 'Confirm password',
                isPassword: true,
                controller: _confirmPasswordController,
                hintText: 'Confirm password',
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CommonFilledButton(
                      onPressed: () {
                        _formKey.currentState!.validate();
                      },
                      text: 'Sign up',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CommonFilledButton(
                      onPressed: () {},
                      text: 'Sign in',
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
}
