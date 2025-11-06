import 'package:flutter/material.dart';

class CommonTextField extends StatefulWidget {
  const CommonTextField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.hintText,
    required this.validator,
    required this.isPassword,
  });

  final String labelText;
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final bool isPassword;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.isPassword ? _isObscure : false,

      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        suffixIcon: widget.isPassword
            ? (_isObscure
                  ? IconButton(
                      onPressed: () {
                        setState(() => _isObscure = false);
                      },
                      icon: Icon(Icons.visibility),
                    )
                  : IconButton(
                      onPressed: () {
                        setState(() => _isObscure = true);
                      },
                      icon: Icon(Icons.visibility_off),
                    ))
            : null,
        enabledBorder: OutlineInputBorder(),
        disabledBorder: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        border: OutlineInputBorder(),
      ),
    );
  }
}
