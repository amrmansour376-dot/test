import 'package:flutter/material.dart';
import 'package:flutter_coffeee/core/constants/app_constants.dart';
import 'package:flutter_coffeee/core/data/local_exercise_catalog.dart';
import 'package:flutter_coffeee/core/state/app_state.dart';
import 'package:flutter_coffeee/core/theme/app_colors.dart';
import 'package:flutter_coffeee/core/theme/app_text_styles.dart';
import 'package:flutter_coffeee/core/utils/app_snackbars.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ExerciseView extends StatefulWidget {
  const ExerciseView({super.key});

  @override
  State<ExerciseView> createState() => _ExerciseViewState();
}

class _ExerciseViewState extends State<ExerciseView> {
  final _searchController = TextEditingController();
  int _categoryIndex = 0;
  bool _favoritesOnly = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState.instance,
      builder: (context, _) {
        final favorites = AppState.instance.favoriteExerciseIds;
        final exercises = LocalExerciseCatalog.filter(
          query: _searchController.text,
          category: LocalExerciseCatalog.categories[_categoryIndex],
          favoritesOnly: _favoritesOnly,
          favoriteIds: favorites,
        );

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
                    totalSwitches: LocalExerciseCatalog.categories.length,
                    labels: LocalExerciseCatalog.categories,
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
                                  AppState.instance.isFavorite(exercise.id);
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
                                    AppState.instance.toggleFavorite(exercise.id);
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
      },
    );
  }

  void _showExerciseDetails(BuildContext context, ExerciseItem exercise) {
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
                  AppState.instance.switchTab(1);
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
