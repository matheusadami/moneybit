import 'package:flutter/material.dart';
import 'package:moneybit/theme/app.colors.dart';
import 'package:moneybit/theme/app.textstyles.dart';

class InputText extends StatelessWidget {
  final IconData icon;
  final String labelText;
  final TextEditingController controller;
  final void Function(String?)? onChanged;
  final String? Function(String?)? functionValidator;
  final TextInputType keyboardType;

  const InputText({
    Key? key,
    required this.icon,
    required this.labelText,
    required this.controller,
    this.functionValidator,
    this.onChanged,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTextStyles.stringInputDarkGray,
      controller: controller,
      cursorColor: AppColors.darkGray,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        isCollapsed: true,
        prefixIcon: Icon(
          icon,
          color: AppColors.silver,
        ),
        labelText: labelText,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: AppColors.indigoBlue,
          ),
        ),
      ),
      validator: functionValidator,
      onChanged: onChanged,
    );
  }
}
