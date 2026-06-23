import 'package:flutter/material.dart';
import 'package:flutter_coffeee/core/constants/app_constants.dart';
import 'package:flutter_coffeee/core/state/app_state.dart';
import 'package:flutter_coffeee/core/theme/app_colors.dart';
import 'package:flutter_coffeee/core/theme/app_text_styles.dart';

class ProgressView extends StatelessWidget {
  const ProgressView({super.key});

  static String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    final hour = date.hour > 12 ? date.hour - 12 : (date.hour == 0 ? 12 : date.hour);
    final period = date.hour >= 12 ? 'PM' : 'AM';
    final minute = date.minute.toString().padLeft(2, '0');
    return '${months[date.month - 1]} ${date.day} · $hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState.instance,
      builder: (context, _) {
        final state = AppState.instance;
        final history = state.workoutHistory;

        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.screenHorizontalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text('Progress', style: AppTextStyles.screenTitleLarge),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: _SummaryCard(
                          label: 'This Week',
                          value: '${state.weeklyWorkoutCount}',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _SummaryCard(
                          label: 'All Time',
                          value: '${state.totalWorkouts}',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text('Recent Sessions', style: AppTextStyles.sectionHeader),
                  const SizedBox(height: 12),
                  Expanded(
                    child: history.isEmpty
                        ? Center(
                            child: Text(
                              'Complete a workout day to see progress here.',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.aboutDescription,
                            ),
                          )
                        : ListView.separated(
                            itemCount: history.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 8),
                            itemBuilder: (context, index) {
                              final session = history[index];
                              return ListTile(
                                tileColor: AppColors.cardColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                leading: CircleAvatar(
                                  backgroundColor:
                                      AppColors.accentColor.withValues(alpha: 0.2),
                                  child: const Icon(
                                    Icons.check,
                                    color: AppColors.accentColor,
                                  ),
                                ),
                                title: Text(
                                  session.dayName,
                                  style: AppTextStyles.settingsItem,
                                ),
                                subtitle: Text(
                                  '${session.muscleGroup} · ${session.exerciseCount} exercises\n'
                                  '${_formatDate(session.completedAt)}',
                                  style: AppTextStyles.settingsValue,
                                ),
                                isThreeLine: true,
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.inputLabel),
          const SizedBox(height: 8),
          Text(value, style: AppTextStyles.profileName.copyWith(fontSize: 28)),
        ],
      ),
    );
  }
}
