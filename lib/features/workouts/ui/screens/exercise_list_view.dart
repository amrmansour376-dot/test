import 'package:flutter/material.dart';
import 'package:flutter_coffeee/core/mock/mock_data.dart';
import 'package:flutter_coffeee/core/theme/app_color.dart';
import 'package:flutter_coffeee/core/theme/app_text_styles.dart';
import 'package:flutter_coffeee/core/utils/app_snackbars.dart';
import 'package:flutter_coffeee/core/widget/custom_text.dart';
import 'package:flutter_coffeee/features/profile/ui/widgets/primary_action_button.dart';
import 'package:flutter_coffeee/features/workouts/ui/widgets/custom_backBtn.dart';

class ExerciseListView extends StatefulWidget {
  final String name;
  final String muscle;

  const ExerciseListView({super.key, required this.muscle, required this.name});

  @override
  State<ExerciseListView> createState() => _ExerciseListViewState();
}

class _ExerciseListViewState extends State<ExerciseListView> {
  bool _isCompleting = false;

  Future<void> _completeWorkout(int exerciseCount) async {
    setState(() => _isCompleting = true);
    await Future<void>.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;
    setState(() => _isCompleting = false);
    AppSnackbars.showSuccess(context, 'Workout completed! Progress updated.');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final exercises = MockData.exercisesForMuscle(widget.muscle);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.backgroundColor,
            pinned: true,
            leading: Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: CustomBackButton(),
            ),
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.only(top: 56, left: 24, right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: widget.name,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 4),
                    CustomText(
                      text: widget.muscle,
                      color: Colors.grey.shade200,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
            sliver: SliverList.separated(
              itemCount: exercises.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final exercise = exercises[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.05),
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            AppColors.accentColor.withValues(alpha: 0.15),
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(color: AppColors.accentColor),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              exercise.name,
                              style: AppTextStyles.settingsItem,
                            ),
                            Text(
                              '${exercise.defaultSets} sets × ${exercise.defaultReps} reps',
                              style: AppTextStyles.settingsValue,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: PrimaryActionButton(
            label: 'Complete Workout',
            isLoading: _isCompleting,
            onPressed: () => _completeWorkout(exercises.length),
          ),
        ),
      ),
    );
  }
}
