import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_surface.dart';
import '../../../../core/widgets/responsive_content.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../cubit/task_cubit.dart';
import '../../../../models/task_model.dart';
import '../widgets/task_date_field.dart';
import '../widgets/task_form_field.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key, this.task});

  final TaskModel? task;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _dueDate;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final task = widget.task;
    if (task != null) {
      _titleController.text = task.title;
      _descriptionController.text = task.description;
      _dueDate = task.dueDate;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final today = _dateOnly(DateTime.now());
    final existingDate = _dueDate == null ? null : _dateOnly(_dueDate!);
    final firstDate = existingDate != null && existingDate.isBefore(today)
        ? existingDate
        : today;
    final selectedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: DateTime(
        today.year + AppFormLimits.maxDateYears,
        today.month,
        today.day,
      ),
      initialDate: existingDate ?? today,
      helpText: 'Choose a due date',
    );
    if (!mounted || selectedDate == null) {
      return;
    }
    setState(() => _dueDate = _dateOnly(selectedDate));
  }

  void _clearDate() {
    setState(() => _dueDate = null);
  }

  Future<void> _saveTask() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() => _isSaving = true);
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final existingTask = widget.task;
    final task = existingTask == null
        ? TaskModel.create(
            title: title,
            description: description,
            dueDate: _dueDate,
          )
        : existingTask.copyWith(
            title: title,
            description: description,
            dueDate: _dueDate,
            clearDueDate: _dueDate == null,
          );
    final cubit = context.read<TaskCubit>();
    final saved = existingTask == null
        ? await cubit.addTask(task)
        : await cubit.updateTask(task);
    if (!mounted) {
      return;
    }
    if (saved) {
      Navigator.of(context).pop();
      return;
    }
    setState(() => _isSaving = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isEditing = widget.task != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit task' : 'Add task'),
        actions: [
          if (_isSaving)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.lg),
              child: Center(
                child: SizedBox(
                  width: AppDimensions.iconSizeSm,
                  height: AppDimensions.iconSizeSm,
                  child: CircularProgressIndicator(
                    strokeWidth: AppDimensions.outlinedStrokeWidth,
                    color: scheme.primary,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: ResponsiveContent(
          maxWidth: AppDimensions.formMaxWidth,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.max,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      StatusBadge(
                        label: isEditing ? 'Editing task' : 'New task',
                        tone: StatusBadgeTone.primary,
                        icon: isEditing
                            ? Icons.edit_outlined
                            : Icons.add_task_rounded,
                      ),
                      const Spacer(),
                      Text(
                        isEditing
                            ? 'Update the details below'
                            : 'Keep it clear and actionable',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppSurface(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TaskFormField(
                          label: 'Task title',
                          hint: 'What needs to get done?',
                          controller: _titleController,
                          icon: Icons.title_rounded,
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a task title';
                            }
                            if (value.trim().length >
                                AppFormLimits.titleMaxLength) {
                              return 'Keep the title under ${AppFormLimits.titleMaxLength} characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        TaskFormField(
                          label: 'Description',
                          hint: 'Add context or a useful next step (optional)',
                          controller: _descriptionController,
                          icon: Icons.notes_rounded,
                          maxLines: AppFormLimits.descriptionMaxLines,
                          minLines: AppFormLimits.descriptionMinLines,
                          keyboardType: TextInputType.multiline,
                          validator: (value) {
                            if (value != null &&
                                value.trim().length >
                                    AppFormLimits.descriptionMaxLength) {
                              return 'Keep the description under ${AppFormLimits.descriptionMaxLength} characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        TaskDateField(
                          dueDate: _dueDate,
                          onSelect: _selectDate,
                          onClear: _clearDate,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Wrap(
                    alignment: WrapAlignment.end,
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      OutlinedButton(
                        onPressed: _isSaving
                            ? null
                            : () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      FilledButton.icon(
                        onPressed: _isSaving ? null : _saveTask,
                        icon: _isSaving
                            ? const SizedBox(
                                width: AppDimensions.iconSizeSm,
                                height: AppDimensions.iconSizeSm,
                                child: CircularProgressIndicator(
                                  strokeWidth:
                                      AppDimensions.outlinedStrokeWidth,
                                ),
                              )
                            : Icon(
                                isEditing
                                    ? Icons.check_rounded
                                    : Icons.add_rounded,
                              ),
                        label: Text(isEditing ? 'Save changes' : 'Create task'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static DateTime _dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}
