import 'package:flutter/material.dart';
import 'package:simple_page/colors/color_widgets.dart';

class CustomTextFieldComponents extends StatefulWidget {
  final TextEditingController controller;
  final bool isPasswordField;
  final String labelText;
  final String hintText;
  final IconData icon;

  const CustomTextFieldComponents({
    super.key,
    required this.controller,
    this.isPasswordField = false, // Default should be false
    required this.labelText,
    required this.hintText,
    required this.icon,
  });

  @override
  _CustomTextFieldComponentsState createState() =>
      _CustomTextFieldComponentsState();
}

class _CustomTextFieldComponentsState extends State<CustomTextFieldComponents> {
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPasswordField ? isObscured : false,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: AppColors.tdBlue1, width: 2),
          ),
          prefixIcon: Icon(
            widget.icon,
            color: AppColors.tdBlue1,
          ),
          suffixIcon: widget.isPasswordField
              ? IconButton(
                  icon: Icon(
                      isObscured ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      isObscured = !isObscured;
                    });
                  },
                )
              : null,
        ),
        /**
         *         validator: (value) {
          if (value == null || value.isEmpty) {
            return '${widget.labelText} cannot be empty';
          }
          return null;
        },
         */
        validator: (value) =>  _passwordAndEmailValadation(value),
      ),
    );
  }

  String? _passwordAndEmailValadation(String? value) {
    if ((value ?? '').isEmpty) {
      return '${widget.labelText} cannot be empty';
    }
    // email valadation.
    if (widget.labelText.toLowerCase().contains("email")) {
      final emailRegex =
          RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
      if (!emailRegex.hasMatch(value!)) {
        return 'Enter a valid email address';
      }
    }
    // password valadation.
    if (widget.labelText.toLowerCase().contains("password")) {
      final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,15}$');
      if (!passwordRegex.hasMatch(value!)) {
        return 'Password must be at least 8-15 characters long and contain letters & numbers';
      }
    }
    return null;
  }
}
