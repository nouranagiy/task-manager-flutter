import 'package:flutter/material.dart';

class TaskSearchField extends StatelessWidget {
  const TaskSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
    required this.hasQuery,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final bool hasQuery;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Search by title or description',
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: hasQuery
            ? IconButton(
                onPressed: onClear,
                tooltip: 'Clear search',
                icon: const Icon(Icons.close_rounded),
              )
            : null,
      ),
    );
  }
}
