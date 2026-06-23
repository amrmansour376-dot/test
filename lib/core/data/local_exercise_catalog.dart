class ExerciseItem {
  final String id;
  final String name;
  final String muscleGroup;
  final String category;
  final int defaultSets;
  final int defaultReps;

  const ExerciseItem({
    required this.id,
    required this.name,
    required this.muscleGroup,
    required this.category,
    this.defaultSets = 3,
    this.defaultReps = 12,
  });
}

class LocalExerciseCatalog {
  const LocalExerciseCatalog._();

  static const categories = [
    'All',
    'Strength',
    'Cardio',
    'Flexibility',
  ];

  static const allExercises = [
    ExerciseItem(
      id: 'bench_press',
      name: 'Barbell Bench Press',
      muscleGroup: 'Chest',
      category: 'Strength',
    ),
    ExerciseItem(
      id: 'incline_db_press',
      name: 'Incline Dumbbell Press',
      muscleGroup: 'Chest',
      category: 'Strength',
    ),
    ExerciseItem(
      id: 'cable_fly',
      name: 'Cable Fly',
      muscleGroup: 'Chest',
      category: 'Strength',
    ),
    ExerciseItem(
      id: 'pull_up',
      name: 'Pull Up',
      muscleGroup: 'Back',
      category: 'Strength',
    ),
    ExerciseItem(
      id: 'barbell_row',
      name: 'Barbell Row',
      muscleGroup: 'Back',
      category: 'Strength',
    ),
    ExerciseItem(
      id: 'lat_pulldown',
      name: 'Lat Pulldown',
      muscleGroup: 'Back',
      category: 'Strength',
    ),
    ExerciseItem(
      id: 'squat',
      name: 'Barbell Squat',
      muscleGroup: 'Legs',
      category: 'Strength',
    ),
    ExerciseItem(
      id: 'leg_press',
      name: 'Leg Press',
      muscleGroup: 'Legs',
      category: 'Strength',
    ),
    ExerciseItem(
      id: 'romanian_deadlift',
      name: 'Romanian Deadlift',
      muscleGroup: 'Legs',
      category: 'Strength',
    ),
    ExerciseItem(
      id: 'ohp',
      name: 'Overhead Press',
      muscleGroup: 'Shoulders',
      category: 'Strength',
    ),
    ExerciseItem(
      id: 'lateral_raise',
      name: 'Lateral Raise',
      muscleGroup: 'Shoulders',
      category: 'Strength',
    ),
    ExerciseItem(
      id: 'barbell_curl',
      name: 'Barbell Curl',
      muscleGroup: 'Arms',
      category: 'Strength',
    ),
    ExerciseItem(
      id: 'tricep_pushdown',
      name: 'Tricep Pushdown',
      muscleGroup: 'Arms',
      category: 'Strength',
    ),
    ExerciseItem(
      id: 'plank',
      name: 'Plank',
      muscleGroup: 'Core',
      category: 'Strength',
    ),
    ExerciseItem(
      id: 'treadmill_run',
      name: 'Treadmill Run',
      muscleGroup: 'Cardio',
      category: 'Cardio',
      defaultSets: 1,
      defaultReps: 20,
    ),
    ExerciseItem(
      id: 'jump_rope',
      name: 'Jump Rope',
      muscleGroup: 'Cardio',
      category: 'Cardio',
      defaultSets: 1,
      defaultReps: 15,
    ),
    ExerciseItem(
      id: 'yoga_stretch',
      name: 'Full Body Stretch',
      muscleGroup: 'Flexibility',
      category: 'Flexibility',
      defaultSets: 1,
      defaultReps: 10,
    ),
  ];

  static List<ExerciseItem> forMuscleGroup(String muscle) {
    final normalized = muscle.trim().toLowerCase();
    if (normalized.isEmpty) {
      return allExercises.take(6).toList();
    }

    final matches = allExercises
        .where((exercise) =>
            exercise.muscleGroup.toLowerCase().contains(normalized) ||
            normalized.contains(exercise.muscleGroup.toLowerCase()))
        .toList();

    if (matches.isNotEmpty) return matches;

    return allExercises
        .where((exercise) => exercise.category == 'Strength')
        .take(5)
        .toList();
  }

  static List<ExerciseItem> filter({
    String query = '',
    String category = 'All',
    bool favoritesOnly = false,
    Set<String> favoriteIds = const {},
  }) {
    return allExercises.where((exercise) {
      final matchesQuery = query.isEmpty ||
          exercise.name.toLowerCase().contains(query.toLowerCase()) ||
          exercise.muscleGroup.toLowerCase().contains(query.toLowerCase());
      final matchesCategory =
          category == 'All' || exercise.category == category;
      final matchesFavorite =
          !favoritesOnly || favoriteIds.contains(exercise.id);
      return matchesQuery && matchesCategory && matchesFavorite;
    }).toList();
  }
}
