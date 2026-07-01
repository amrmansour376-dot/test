import 'package:flutter_coffeee/core/constants/app_constants.dart';

class MockExercise {
  final String id;
  final String name;
  final String muscleGroup;
  final String category;
  final int defaultSets;
  final int defaultReps;

  const MockExercise({
    required this.id,
    required this.name,
    required this.muscleGroup,
    required this.category,
    this.defaultSets = 3,
    this.defaultReps = 12,
  });
}

class MockWorkoutSystem {
  final int id;
  final String name;
  final String description;
  final String imageUrl;

  const MockWorkoutSystem({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });
}

class MockWorkoutDay {
  final int systemId;
  final String dayName;
  final String muscle;

  const MockWorkoutDay({
    required this.systemId,
    required this.dayName,
    required this.muscle,
  });
}

class MockCustomProgram {
  final String id;
  final String name;
  final String description;
  final int daysPerWeek;

  const MockCustomProgram({
    required this.id,
    required this.name,
    required this.description,
    required this.daysPerWeek,
  });
}

class MockWorkoutSession {
  final String dayName;
  final String muscleGroup;
  final int exerciseCount;
  final DateTime completedAt;

  const MockWorkoutSession({
    required this.dayName,
    required this.muscleGroup,
    required this.exerciseCount,
    required this.completedAt,
  });
}

class MockData {
  MockData._();

  static const String userFullName = AppConstants.userFullName;
  static const String userEmail = AppConstants.userEmail;
  static const String userHeight = AppConstants.userHeight;
  static const String userWeight = AppConstants.userWeight;
  static const String userDateOfBirth = AppConstants.userDateOfBirth;
  static const String userGender = AppConstants.userGender;
  static const String profileImageUrl = AppConstants.profileImageUrl;

  static const String units = AppConstants.unitsValue;
  static const String workoutReminderTime = '07:00 AM';
  static const bool workoutRemindersEnabled = true;
  static const int restTimerSeconds = 45;

  static const int weeklyWorkoutCount = 0;
  static const int totalWorkouts = 0;

  static const Map<String, bool> fitnessGoals = {
    'Lose Weight': false,
    'Build Muscle': true,
    'Improve Endurance': false,
    'Increase Flexibility': false,
    'Stay Active': true,
  };

  static const List<String> exerciseCategories = [
    'All',
    'Strength',
    'Cardio',
    'Flexibility',
  ];

  static const List<MockExercise> exercises = [
    MockExercise(
      id: 'bench_press',
      name: 'Barbell Bench Press',
      muscleGroup: 'Chest',
      category: 'Strength',
    ),
    MockExercise(
      id: 'incline_db_press',
      name: 'Incline Dumbbell Press',
      muscleGroup: 'Chest',
      category: 'Strength',
    ),
    MockExercise(
      id: 'cable_fly',
      name: 'Cable Fly',
      muscleGroup: 'Chest',
      category: 'Strength',
    ),
    MockExercise(
      id: 'pull_up',
      name: 'Pull Up',
      muscleGroup: 'Back',
      category: 'Strength',
    ),
    MockExercise(
      id: 'barbell_row',
      name: 'Barbell Row',
      muscleGroup: 'Back',
      category: 'Strength',
    ),
    MockExercise(
      id: 'lat_pulldown',
      name: 'Lat Pulldown',
      muscleGroup: 'Back',
      category: 'Strength',
    ),
    MockExercise(
      id: 'squat',
      name: 'Barbell Squat',
      muscleGroup: 'Legs',
      category: 'Strength',
    ),
    MockExercise(
      id: 'leg_press',
      name: 'Leg Press',
      muscleGroup: 'Legs',
      category: 'Strength',
    ),
    MockExercise(
      id: 'romanian_deadlift',
      name: 'Romanian Deadlift',
      muscleGroup: 'Legs',
      category: 'Strength',
    ),
    MockExercise(
      id: 'ohp',
      name: 'Overhead Press',
      muscleGroup: 'Shoulders',
      category: 'Strength',
    ),
    MockExercise(
      id: 'lateral_raise',
      name: 'Lateral Raise',
      muscleGroup: 'Shoulders',
      category: 'Strength',
    ),
    MockExercise(
      id: 'barbell_curl',
      name: 'Barbell Curl',
      muscleGroup: 'Arms',
      category: 'Strength',
    ),
    MockExercise(
      id: 'tricep_pushdown',
      name: 'Tricep Pushdown',
      muscleGroup: 'Arms',
      category: 'Strength',
    ),
    MockExercise(
      id: 'plank',
      name: 'Plank',
      muscleGroup: 'Core',
      category: 'Strength',
    ),
    MockExercise(
      id: 'treadmill_run',
      name: 'Treadmill Run',
      muscleGroup: 'Cardio',
      category: 'Cardio',
      defaultSets: 1,
      defaultReps: 20,
    ),
    MockExercise(
      id: 'jump_rope',
      name: 'Jump Rope',
      muscleGroup: 'Cardio',
      category: 'Cardio',
      defaultSets: 1,
      defaultReps: 15,
    ),
    MockExercise(
      id: 'yoga_stretch',
      name: 'Full Body Stretch',
      muscleGroup: 'Flexibility',
      category: 'Flexibility',
      defaultSets: 1,
      defaultReps: 10,
    ),
  ];

  static const List<MockWorkoutSystem> workoutSystems = [
    MockWorkoutSystem(
      id: 1,
      name: 'Push Pull Legs',
      description: 'Classic 6-day split focusing on push, pull, and leg movements.',
      imageUrl:
          'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=800',
    ),
    MockWorkoutSystem(
      id: 2,
      name: 'Upper Lower Split',
      description: 'Four-day program alternating upper and lower body sessions.',
      imageUrl:
          'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=800',
    ),
    MockWorkoutSystem(
      id: 3,
      name: 'Full Body Strength',
      description: 'Three-day full body routine for balanced strength development.',
      imageUrl:
          'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=800',
    ),
  ];

  static const List<MockWorkoutDay> workoutDays = [
    MockWorkoutDay(systemId: 1, dayName: 'Push Day A', muscle: 'Chest'),
    MockWorkoutDay(systemId: 1, dayName: 'Pull Day A', muscle: 'Back'),
    MockWorkoutDay(systemId: 1, dayName: 'Leg Day A', muscle: 'Legs'),
    MockWorkoutDay(systemId: 1, dayName: 'Push Day B', muscle: 'Shoulders'),
    MockWorkoutDay(systemId: 1, dayName: 'Pull Day B', muscle: 'Back'),
    MockWorkoutDay(systemId: 1, dayName: 'Leg Day B', muscle: 'Legs'),
    MockWorkoutDay(systemId: 2, dayName: 'Upper Body', muscle: 'Chest'),
    MockWorkoutDay(systemId: 2, dayName: 'Lower Body', muscle: 'Legs'),
    MockWorkoutDay(systemId: 2, dayName: 'Upper Body B', muscle: 'Back'),
    MockWorkoutDay(systemId: 2, dayName: 'Lower Body B', muscle: 'Legs'),
    MockWorkoutDay(systemId: 3, dayName: 'Full Body A', muscle: 'Chest'),
    MockWorkoutDay(systemId: 3, dayName: 'Full Body B', muscle: 'Back'),
    MockWorkoutDay(systemId: 3, dayName: 'Full Body C', muscle: 'Legs'),
  ];

  static const List<MockWorkoutSession> workoutHistory = [];

  static List<MockWorkoutDay> daysForSystem(int systemId) {
    return workoutDays.where((day) => day.systemId == systemId).toList();
  }

  static List<MockExercise> exercisesForMuscle(String muscle) {
    final normalized = muscle.trim().toLowerCase();
    if (normalized.isEmpty) {
      return exercises.take(6).toList();
    }

    final matches = exercises
        .where(
          (exercise) =>
              exercise.muscleGroup.toLowerCase().contains(normalized) ||
              normalized.contains(exercise.muscleGroup.toLowerCase()),
        )
        .toList();

    if (matches.isNotEmpty) return matches;

    return exercises
        .where((exercise) => exercise.category == 'Strength')
        .take(5)
        .toList();
  }

  static String get activeGoalsLabel {
    return fitnessGoals.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .take(2)
        .join(' · ');
  }

  static String get restTimerLabel => '$restTimerSeconds sec';

  static String get workoutRemindersLabel =>
      workoutRemindersEnabled ? 'On · $workoutReminderTime' : 'Off';

  static String get bodyMassIndex {
    final heightMatch = RegExp(r'(\d+(?:\.\d+)?)').firstMatch(userHeight);
    final weightMatch = RegExp(r'(\d+(?:\.\d+)?)').firstMatch(userWeight);
    final heightCm = heightMatch == null
        ? null
        : double.tryParse(heightMatch.group(1)!);
    final weightKg = weightMatch == null
        ? null
        : double.tryParse(weightMatch.group(1)!);

    if (heightCm == null || weightKg == null || heightCm <= 0) {
      return '--';
    }

    final bmi = weightKg / ((heightCm / 100) * (heightCm / 100));
    return bmi.toStringAsFixed(1);
  }
}
