import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/widgets/offline_banner.dart';
import '../provider/task_provider.dart';
import 'task_card.dart';
import 'task_from_sheet.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(taskProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Task Manager'),
        scrolledUnderElevation: 0,
        elevation: 0,
        actions: [

          Consumer(
            builder: (_, ref, __) {
              final mode = ref.watch(themeModeProvider);
              final isDark = mode == ThemeMode.dark;
              return IconButton(
                icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                onPressed: () {
                  ref.read(themeModeProvider.notifier).state =
                  isDark ? ThemeMode.light : ThemeMode.dark;
                },
              );
            },
          ),
        ],

        // 🔍 SEARCH
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              onChanged: (v) =>
                  ref.read(taskProvider.notifier).setSearch(v),
              decoration: InputDecoration(
                hintText: 'Search tasks…',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          const OfflineBanner(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _FilterPill(
                    icon: Icons.pending_actions,
                    label: 'Pending',
                    onTap: () =>
                        ref.read(taskProvider.notifier).setStatus('pending'),
                  ),
                  _FilterPill(
                    icon: Icons.check_circle_outline,
                    label: 'Completed',
                    onTap: () =>
                        ref.read(taskProvider.notifier).setStatus('completed'),
                  ),
                  _FilterPill(
                    icon: Icons.priority_high,
                    label: 'High',
                    onTap: () =>
                        ref.read(taskProvider.notifier).setPriority('high'),
                  ),
                  _FilterPill(
                    icon: Icons.event,
                    label: 'Scheduling',
                    onTap: () =>
                        ref.read(taskProvider.notifier)
                            .setCategory('scheduling'),
                  ),
                  _FilterPill(
                    icon: Icons.clear_all,
                    label: 'Clear',
                    onTap: () =>
                        ref.read(taskProvider.notifier).clearFilters(),
                  ),
                ],
              ),
            ),
          ),
          
          Expanded(
            child: state.when(
              loading: () =>
              const Center(child: CircularProgressIndicator()),
              error: (_, __) =>
              const Center(child: Text('Failed to load tasks')),
              data: (tasks) {
                if (tasks.isEmpty) {
                  return const Center(child: Text('No tasks found'));
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await ref.read(taskProvider.notifier).loadTasks();
                  },
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: tasks.length,
                    itemBuilder: (_, i) => TaskCard(task: tasks[i]),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add_task),
        label: const Text('New Task'),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            builder: (_) => const TaskFormSheet(),
          );
        },
      ),
    );
  }
}

class _FilterPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _FilterPill({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 18),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
    );
  }
}
