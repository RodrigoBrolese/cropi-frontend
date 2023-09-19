import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatelessWidget {
  const Input(
      {required this.label,
      this.initialValue,
      this.controller,
      this.type,
      this.error,
      this.onChanged,
      this.validate,
      this.formatters,
      this.inputAction,
      this.onFieldSubmitted,
      this.onTap,
      this.prefixIcon,
      this.suffixIcon,
      this.focusNode,
      this.autocorrect = true,
      this.obscureText = false,
      this.enableSuggestions = true,
      this.readOnly = false,
      super.key});

  final String label;
  final TextEditingController? controller;
  final String? error;
  final String? initialValue;
  final Function? onChanged;
  final Function? onTap;
  final Function? onFieldSubmitted;
  final Function? validate;
  final TextInputType? type;
  final List<TextInputFormatter>? formatters;
  final TextInputAction? inputAction;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type ?? TextInputType.text,
      validator: validate as String? Function(String?)?,
      onChanged: onChanged as void Function(String)?,
      onFieldSubmitted: onFieldSubmitted as void Function(String)?,
      inputFormatters: formatters ?? [],
      focusNode: focusNode,
      onTap: onTap as void Function()?,
      initialValue: initialValue,
      textInputAction: inputAction,
      obscureText: obscureText,
      enableSuggestions: enableSuggestions,
      autocorrect: autocorrect,
      readOnly: readOnly,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(2)),
        labelText: label,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding:
            const EdgeInsets.only(top: 21, bottom: 21, left: 12, right: 12),
        errorText: error,
        errorStyle: const TextStyle(
            color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}
