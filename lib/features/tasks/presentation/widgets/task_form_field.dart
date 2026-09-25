import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class TaskFormField extends StatelessWidget {
  const TaskFormField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.icon,
    this.maxLines = 1,
    this.minLines,
    this.validator,
    this.textInputAction,
    this.keyboardType,
    this.autofocus = false,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final IconData icon;
  final int maxLines;
  final int? minLines;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.titleSmall),
        const SizedBox(height: AppSpacing.xs),
        TextFormField(
          controller: controller,
          autofocus: autofocus,
          maxLines: maxLines,
          minLines: minLines,
          validator: validator,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            alignLabelWithHint: maxLines > 1,
          ),
        ),
      ],
    );
  }
}
