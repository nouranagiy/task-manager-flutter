import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/responsive_content.dart';
import '../../../../models/task_model.dart';
import 'task_card.dart';
import 'task_empty_state.dart';
import 'task_filter.dart';
import 'task_page_header.dart';
import 'task_search_field.dart';
import 'task_summary_card.dart';

class TaskDashboardView extends StatelessWidget {
  const TaskDashboardView({
    super.key,
    required this.visibleTasks,
    required this.totalCount,
    required this.completedCount,
    required this.pendingCount,
    required this.selectedFilter,
    required this.searchController,
    required this.searchQuery,
    required this.isLoading,
    required this.hasError,
    required this.isDarkMode,
    required this.isWide,
    required this.onThemeToggle,
    required this.onSearchChanged,
    required this.onClearSearch,
    required this.onCreate,
    required this.onResetView,
    required this.onRetry,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
    required this.onViewDetails,
  });

  final List<TaskModel> visibleTasks;
  final int totalCount;
  final int completedCount;
  final int pendingCount;
  final TaskFilter selectedFilter;
  final TextEditingController searchController;
  final String searchQuery;
  final bool isLoading;
  final bool hasError;
  final bool isDarkMode;
  final bool isWide;
  final VoidCallback onThemeToggle;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onClearSearch;
  final VoidCallback onCreate;
  final VoidCallback onResetView;
  final VoidCallback onRetry;
  final ValueChanged<TaskModel> onToggle;
  final ValueChanged<TaskModel> onEdit;
  final ValueChanged<TaskModel> onDelete;
  final ValueChanged<TaskModel> onViewDetails;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final horizontalPadding = isWide ? AppSpacing.xxl : AppSpacing.lg;
    final visibleCount = visibleTasks.length;

    return ResponsiveContent(
      child: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              horizontalPadding,
              AppSpacing.lg,
              horizontalPadding,
              AppSpacing.lg,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TaskPageHeader(
                    isDarkMode: isDarkMode,
                    onThemeToggle: onThemeToggle,
                    showThemeToggle: !isWide,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  TaskSummaryCard(
                    total: totalCount,
                    completed: completedCount,
                    pending: pendingCount,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  TaskSearchField(
                    controller: searchController,
                    onChanged: onSearchChanged,
                    onClear: onClearSearch,
                    hasQuery: searchQuery.isNotEmpty,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Row(
                    children: [
                      Text('Your tasks', style: theme.textTheme.titleLarge),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        visibleCount.toString(),
                        style: theme.textTheme.labelMedium,
                      ),
                      const Spacer(),
                      if (isLoading)
                        const SizedBox(
                          width: AppDimensions.iconSizeSm,
                          height: AppDimensions.iconSizeSm,
                          child: CircularProgressIndicator(
                            strokeWidth: AppDimensions.outlinedStrokeWidth,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (hasError && totalCount == 0)
            SliverFillRemaining(
              hasScrollBody: false,
              child: _TaskErrorState(onRetry: onRetry),
            )
          else if (visibleTasks.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: TaskEmptyState(
                isSearching: searchQuery.trim().isNotEmpty,
                filter: selectedFilter,
                onCreate: onCreate,
                onReset: onResetView,
              ),
            )
          else
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                0,
                horizontalPadding,
                AppSpacing.max,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final task = visibleTasks[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: TaskCard(
                      task: task,
                      onToggle: () => onToggle(task),
                      onEdit: () => onEdit(task),
                      onDelete: () => onDelete(task),
                      onViewDetails: () => onViewDetails(task),
                    ),
                  );
                }, childCount: visibleTasks.length),
              ),
            ),
        ],
      ),
    );
  }
}

class _TaskErrorState extends StatelessWidget {
  const _TaskErrorState({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: AppDimensions.emptyStateMaxWidth,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_off_rounded,
                color: scheme.error,
                size: AppDimensions.iconSizeXl,
              ),
              const SizedBox(height: AppSpacing.md),
              Text('We hit a snag', style: theme.textTheme.headlineSmall),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Your tasks could not be loaded. Try again when you are ready.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.lg),
              OutlinedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Try again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
