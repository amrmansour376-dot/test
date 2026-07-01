import 'package:flutter/material.dart';
import 'package:flutter_coffeee/core/mock/mock_data.dart';
import 'package:flutter_coffeee/features/workouts/ui/screens/system_details_screen.dart';
import 'package:flutter_coffeee/features/workouts/ui/widgets/workout_card.dart';

class PresetPrograms extends StatefulWidget {
  const PresetPrograms({super.key});

  @override
  State<PresetPrograms> createState() => _PresetProgramsState();
}

class _PresetProgramsState extends State<PresetPrograms>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final data = MockData.workoutSystems;

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) => WorkoutCard(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SystemDetailsScreen(
              image: data[index].imageUrl,
              height: 250,
              width: double.infinity,
              systemId: data[index].id,
              description: data[index].description,
              name: data[index].name,
            ),
          ),
        ),
        image: data[index].imageUrl,
        name: data[index].name,
        description: data[index].description,
      ),
    );
  }
}
