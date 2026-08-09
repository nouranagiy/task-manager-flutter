import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/task_cubit.dart';
import '../models/task_model.dart';
import 'add_task_screen.dart';
enum TaskFilter {
  all,
  pending,
  completed,
}
class HomeScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;
  const HomeScreen({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  TaskFilter _selectedFilter = TaskFilter.all;
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  Future<void> _deleteTask(
      BuildContext context,
      String taskId,
      ) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Task'),
        content: Text('Are you sure you want to delete this task?',),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
    if (shouldDelete == true && context.mounted) {
      context.read<TaskCubit>().deleteTask(taskId);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Tasks',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: widget.onThemeToggle,
            icon: Icon(
              widget.isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            ),
            tooltip: widget.isDarkMode ? 'Light Mode' : 'Dark Mode',
          ),
        ],
      ),
      body: BlocBuilder<TaskCubit, List<TaskModel>>(
        builder: (context, tasks) {
          final completedTasks = tasks.where((task) => task.isCompleted).length;
          final pendingTasks = tasks.where((task) => !task.isCompleted).length;
          final filteredTasks = tasks.where((task) {
            final query = _searchQuery.toLowerCase().trim();
            final matchesSearch = task.title.toLowerCase().contains(query) || task.description.toLowerCase().contains(query);
            final matchesFilter = _selectedFilter == TaskFilter.all ||
                    (_selectedFilter == TaskFilter.completed && task.isCompleted) ||
                    (_selectedFilter == TaskFilter.pending && !task.isCompleted);
            return matchesSearch && matchesFilter;
          }).toList();
          return LayoutBuilder(
            builder: (context, constraints) {
              final isTablet = constraints.maxWidth >= 600;
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 40 : 16,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _StatCard(
                            title: 'Total Tasks',
                            value: tasks.length.toString(),
                            icon: Icons.task_alt,
                          ),
                        ),
                        SizedBox(width: isTablet ? 16 : 12,),
                        Expanded(
                          child: _StatCard(
                            title: 'Completed',
                            value: completedTasks.toString(),
                            icon: Icons.check_circle_outline,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {_searchQuery = value;});
                      },
                      decoration: InputDecoration(
                        hintText: 'Search tasks...',
                        prefixIcon: Icon(Icons.search,),
                        suffixIcon: _searchQuery.isNotEmpty ? IconButton(
                          icon: Icon(Icons.clear,),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {_searchQuery = '';});
                          },
                        ) : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),),
                      ),
                    ),
                    SizedBox(height: 16),
                    _FilterBar(
                      selectedFilter: _selectedFilter,
                      allCount: tasks.length,
                      pendingCount: pendingTasks,
                      completedCount: completedTasks,
                      onFilterChanged: (filter) {
                        setState(() {
                          _selectedFilter = filter;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      child: filteredTasks.isEmpty ? _EmptyState(
                        isSearching: _searchQuery.isNotEmpty,
                        filter: _selectedFilter,
                      ) : ListView.builder(
                        itemCount: filteredTasks.length,
                        itemBuilder: (context, index) {
                          final task = filteredTasks[index];
                          return _TaskCard(
                            task: task,
                            onDelete: () {
                              _deleteTask(
                                context,
                                task.id,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddTaskScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
class _FilterBar extends StatelessWidget {
  final TaskFilter selectedFilter;
  final int allCount;
  final int pendingCount;
  final int completedCount;
  final ValueChanged<TaskFilter> onFilterChanged;
  const _FilterBar({
    required this.selectedFilter,
    required this.allCount,
    required this.pendingCount,
    required this.completedCount,
    required this.onFilterChanged,
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _FilterButton(
            title: 'All',
            count: allCount,
            isSelected: selectedFilter == TaskFilter.all,
            onTap: () {
              onFilterChanged(TaskFilter.all);
            },
          ),
          SizedBox(width: 8),
          _FilterButton(
            title: 'Pending',
            count: pendingCount,
            isSelected: selectedFilter == TaskFilter.pending,
            onTap: () {
              onFilterChanged(TaskFilter.pending);
            },
          ),
          SizedBox(width: 8),
          _FilterButton(
            title: 'Completed',
            count: completedCount,
            isSelected: selectedFilter == TaskFilter.completed,
            onTap: () {
              onFilterChanged(TaskFilter.completed);
            },
          ),
        ],
      ),
    );
  }
}
class _FilterButton extends StatelessWidget {
  final String title;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;
  const _FilterButton({
    required this.title,
    required this.count,
    required this.isSelected,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text('$title ($count)'),
      selected: isSelected,
      onSelected: (_) {
        onTap();
      },
    );
  }
}
class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon,
            size: 30,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(title,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 4),
                Text(value,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class _EmptyState extends StatelessWidget {
  final bool isSearching;
  final TaskFilter filter;
  const _EmptyState({
    required this.isSearching,
    required this.filter,
  });
  @override
  Widget build(BuildContext context) {
    String title;
    String subtitle;
    if (isSearching) {
      title = 'No tasks found';
      subtitle = 'Try another search';
    } else if (filter == TaskFilter.completed) {
      title = 'No completed tasks';
      subtitle = 'Complete a task to see it here';
    } else if (filter == TaskFilter.pending) {
      title = 'No pending tasks';
      subtitle = 'All your tasks are completed';
    } else {
      title = 'No tasks yet';
      subtitle = 'Add your first task';
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSearching ? Icons.search_off : Icons.task_alt,
            size: 70,
            color: Colors.grey,
          ),
          SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text(subtitle,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
class _TaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onDelete;
  const _TaskCard({
    required this.task,
    required this.onDelete,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (value) {
            final updatedTask = TaskModel(
              id: task.id,
              title: task.title,
              description: task.description,
              createdAt: task.createdAt,
              dueDate: task.dueDate,
              isCompleted: value ?? false,
            );
            context.read<TaskCubit>().updateTask(updatedTask);
          },
        ),
        title: Text(task.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(
              task.description.isEmpty ? 'No description' : task.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (task.dueDate != null) ...[
              SizedBox(height: 6),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 14,
                  ),
                  SizedBox(width: 4),
                  Text(
                    '${task.dueDate!.day}/'
                        '${task.dueDate!.month}/'
                        '${task.dueDate!.year}',
                    style: TextStyle(fontSize: 12,),
                  ),
                ],
              ),
            ],
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit_outlined,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddTaskScreen(
                      task: task,
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon:  Icon(Icons.delete_outline,),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}