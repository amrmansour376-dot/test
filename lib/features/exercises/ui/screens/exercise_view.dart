import 'package:flutter/material.dart';
import 'package:flutter_coffeee/core/constants/app_constants.dart';
import 'package:flutter_coffeee/core/mock/mock_data.dart';
import 'package:flutter_coffeee/core/theme/app_colors.dart';
import 'package:flutter_coffeee/core/theme/app_text_styles.dart';
import 'package:flutter_coffeee/core/ui/app_ui_bridge.dart';
import 'package:flutter_coffeee/core/utils/app_snackbars.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ExerciseView extends StatefulWidget {
  final ValueChanged<int> onSwitchTab;

  const ExerciseView({super.key, required this.onSwitchTab});

  @override
  State<ExerciseView> createState() => _ExerciseViewState();
}

class _ExerciseViewState extends State<ExerciseView> {
  final _searchController = TextEditingController();
  int _categoryIndex = 0;
  bool _favoritesOnly = false;
  final Set<String> _favoriteExerciseIds = {};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<MockExercise> _filteredExercises() {
    final query = _searchController.text;
    final category = MockData.exerciseCategories[_categoryIndex];

    return MockData.exercises.where((exercise) {
      final matchesQuery = query.isEmpty ||
          exercise.name.toLowerCase().contains(query.toLowerCase()) ||
          exercise.muscleGroup.toLowerCase().contains(query.toLowerCase());
      final matchesCategory = category == 'All' || exercise.category == category;
      final matchesFavorite =
          !_favoritesOnly || _favoriteExerciseIds.contains(exercise.id);
      return matchesQuery && matchesCategory && matchesFavorite;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final exercises = _filteredExercises();

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
              Text('Exercise Library', style: AppTextStyles.screenTitleLarge),
              const SizedBox(height: 16),
              TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                style: AppTextStyles.inputValue,
                decoration: InputDecoration(
                  hintText: 'Search exercises...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: AppColors.inputBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ToggleSwitch(
                minWidth: 72,
                cornerRadius: 20,
                activeBgColors: const [
                  [AppColors.accentColor],
                  [AppColors.accentColor],
                  [AppColors.accentColor],
                  [AppColors.accentColor],
                ],
                inactiveBgColor: AppColors.cardColor,
                initialLabelIndex: _categoryIndex,
                totalSwitches: MockData.exerciseCategories.length,
                labels: MockData.exerciseCategories,
                onToggle: (index) {
                  if (index != null) {
                    setState(() => _categoryIndex = index);
                  }
                },
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Show favorites only'),
                value: _favoritesOnly,
                activeThumbColor: AppColors.accentColor,
                onChanged: (value) => setState(() => _favoritesOnly = value),
              ),
              Expanded(
                child: exercises.isEmpty
                    ? Center(
                        child: Text(
                          'No exercises found',
                          style: AppTextStyles.aboutDescription,
                        ),
                      )
                    : ListView.separated(
                        itemCount: exercises.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final exercise = exercises[index];
                          final isFavorite =
                              _favoriteExerciseIds.contains(exercise.id);
                          return ListTile(
                            tileColor: AppColors.cardColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            title: Text(
                              exercise.name,
                              style: AppTextStyles.settingsItem,
                            ),
                            subtitle: Text(
                              '${exercise.muscleGroup} · ${exercise.defaultSets}x${exercise.defaultReps}',
                              style: AppTextStyles.settingsValue,
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite
                                    ? AppColors.accentColor
                                    : AppColors.textSecondary,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (isFavorite) {
                                    _favoriteExerciseIds.remove(exercise.id);
                                  } else {
                                    _favoriteExerciseIds.add(exercise.id);
                                  }
                                });
                                AppSnackbars.showInfo(
                                  context,
                                  isFavorite
                                      ? 'Removed from favorites'
                                      : 'Added to favorites',
                                );
                              },
                            ),
                            onTap: () => _showExerciseDetails(context, exercise),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showExerciseDetails(BuildContext context, MockExercise exercise) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(exercise.name, style: AppTextStyles.screenTitle),
            const SizedBox(height: 8),
            Text(
              '${exercise.muscleGroup} · ${exercise.category}',
              style: AppTextStyles.aboutDescription,
            ),
            const SizedBox(height: 16),
            Text(
              'Suggested: ${exercise.defaultSets} sets × ${exercise.defaultReps} reps',
              style: AppTextStyles.settingsItem,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentColor,
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  AppUIBridge.switchTab?.call(1);
                  widget.onSwitchTab(1);
                  AppSnackbars.showInfo(
                    context,
                    'Open Workouts to start a program with this exercise',
                  );
                },
                child: const Text('Find in Workout Program'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
