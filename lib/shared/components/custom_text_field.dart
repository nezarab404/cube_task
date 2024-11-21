import '../utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import 'app_text.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.hint,
    this.suffixIcon,
    this.initialValue,
    this.prefixIcon,
    this.isPassword = false,
    this.validator,
    this.isDisabled = false,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.onTap,
  });

  final TextEditingController? controller;
  final String? initialValue;
  final String? hint;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isPassword;
  final bool isDisabled;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final void Function()? onTap;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isPassword = false;

  @override
  void initState() {
    _isPassword = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      textAlignVertical: TextAlignVertical.center,
      controller: widget.controller,
      focusNode: widget.focusNode,
      initialValue: widget.initialValue,
      obscureText: _isPassword,
      obscuringCharacter: '*',
      validator: widget.validator,
      readOnly: widget.isDisabled,
      keyboardType: widget.keyboardType,
      cursorColor: AppColors.primary,
      style: const TextStyle(color: AppColors.black),
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.white),
            borderRadius: BorderRadius.circular(8.r)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.white),
            borderRadius: BorderRadius.circular(8.r)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primary),
            borderRadius: BorderRadius.circular(8.r)),
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: Colors.black54,
          fontSize: 16.sp,
        ),
        border: InputBorder.none,
        suffixIcon: widget.isPassword ? secureWidget : widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        fillColor: AppColors.white,
        filled: true,
      ),
    );
  }

  Widget get secureWidget => IconButton(
        onPressed: () {
          setState(() {
            _isPassword = !_isPassword;
          });
        },
        icon: _isPassword
            ? Icon(
                Icons.visibility_off,
                size: kDefaultFontSize.sp,
              )
            : Icon(
                Icons.visibility,
                size: kDefaultFontSize.sp,
              ),
      );
}

class TextFieldWithTitle extends StatelessWidget {
  const TextFieldWithTitle({
    super.key,
    required this.title,
    required this.child,
    this.required = false,
    this.fontSize = 16,
  });

  final String title;
  final Widget child;
  final bool required;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          AppText(
            text: title,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
          if (required)
            const Text(
              ' *',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
        ],
      ),
      UIHelper.verticalSpaceSmall(),
      child,
    ]
        // .addSpaces(height: 8.h).toList(),
        );
  }
}
