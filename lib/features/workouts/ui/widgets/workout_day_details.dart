import 'package:flutter/material.dart';
import 'package:flutter_coffeee/core/mock/mock_data.dart';
import 'package:flutter_coffeee/core/widget/custom_text.dart';
import 'package:flutter_coffeee/features/workouts/ui/screens/exercise_list_view.dart';
import 'package:flutter_coffeee/features/workouts/ui/widgets/workout_day_card.dart';

class WorkoutDayDetails extends StatelessWidget {
  final int systemId;

  const WorkoutDayDetails({super.key, required this.systemId});

  @override
  Widget build(BuildContext context) {
    final data = MockData.daysForSystem(systemId);

    if (data.isEmpty) {
      return const Center(
        child: CustomText(text: 'No days found for this system'),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) => WorkoutDayCard(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExerciseListView(
              muscle: data[index].muscle,
              name: data[index].dayName,
            ),
          ),
        ),
        name: data[index].dayName,
        muscleGroup: data[index].muscle,
      ),
    );
  }
}
