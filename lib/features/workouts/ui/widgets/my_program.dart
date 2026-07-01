import 'package:flutter/material.dart';
import 'package:flutter_coffeee/core/constants/app_constants.dart';
import 'package:flutter_coffeee/core/mock/mock_data.dart';
import 'package:flutter_coffeee/core/theme/app_colors.dart';
import 'package:flutter_coffeee/core/theme/app_text_styles.dart';
import 'package:flutter_coffeee/core/utils/app_dialogs.dart';
import 'package:flutter_coffeee/core/utils/app_snackbars.dart';
import 'package:flutter_coffeee/features/profile/ui/widgets/primary_action_button.dart';
import 'package:flutter_coffeee/features/workouts/ui/screens/create_program_screen.dart';

class MyProgram extends StatefulWidget {
  const MyProgram({super.key});

  @override
  State<MyProgram> createState() => _MyProgramState();
}

class _MyProgramState extends State<MyProgram> {
  final List<MockCustomProgram> _programs = [];

  Future<void> _openCreateProgram() async {
    final created = await Navigator.push<MockCustomProgram>(
      context,
      MaterialPageRoute(builder: (_) => const CreateProgramScreen()),
    );

    if (created != null && mounted) {
      setState(() => _programs.insert(0, created));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_programs.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.screenHorizontalPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add_circle_outline,
              size: 64,
              color: AppColors.accentColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Create Your Program',
              style: AppTextStyles.screenTitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Build a custom training plan tailored to your schedule.',
              style: AppTextStyles.aboutDescription,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            PrimaryActionButton(
              label: 'Create Program',
              onPressed: _openCreateProgram,
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.screenHorizontalPadding,
            vertical: 8,
          ),
          child: PrimaryActionButton(
            label: 'Create New Program',
            onPressed: _openCreateProgram,
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.screenHorizontalPadding,
            ),
            itemCount: _programs.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final program = _programs[index];
              return Dismissible(
                key: ValueKey(program.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: AppColors.logoutRed.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.delete, color: AppColors.logoutRed),
                ),
                confirmDismiss: (_) => AppDialogs.confirm(
                  context,
                  title: 'Delete Program',
                  message: 'Remove "${program.name}" from your programs?',
                  confirmLabel: 'Delete',
                  isDestructive: true,
                ),
                onDismissed: (_) {
                  setState(() => _programs.removeAt(index));
                  AppSnackbars.showSuccess(context, 'Program deleted');
                },
                child: ListTile(
                  tileColor: AppColors.cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: Text(
                    program.name,
                    style: AppTextStyles.settingsItem,
                  ),
                  subtitle: Text(
                    '${program.daysPerWeek} days/week · ${program.description}',
                    style: AppTextStyles.settingsValue,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(
                    Icons.fitness_center,
                    color: AppColors.accentColor,
                  ),
                  onTap: () {
                    AppSnackbars.showInfo(
                      context,
                      'Custom program "${program.name}" is ready to use',
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
