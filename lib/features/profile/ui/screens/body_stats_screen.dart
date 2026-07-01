import 'package:flutter/material.dart';
import 'package:flutter_coffeee/core/constants/app_constants.dart';
import 'package:flutter_coffeee/core/mock/mock_data.dart';
import 'package:flutter_coffeee/core/theme/app_colors.dart';
import 'package:flutter_coffeee/core/theme/app_text_styles.dart';
import 'package:flutter_coffeee/features/profile/ui/screens/edit_profile_screen.dart';
import 'package:flutter_coffeee/features/profile/ui/widgets/primary_action_button.dart';
import 'package:flutter_coffeee/features/profile/ui/widgets/profile_screen_header.dart';

class BodyStatsScreen extends StatelessWidget {
  const BodyStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.screenHorizontalPadding,
            vertical: 16,
          ),
          child: Column(
            children: [
              const ProfileScreenHeader(title: 'Body Stats'),
              const SizedBox(height: 32),
              _StatCard(label: 'Height', value: MockData.userHeight),
              const SizedBox(height: 12),
              _StatCard(label: 'Weight', value: MockData.userWeight),
              const SizedBox(height: 12),
              _StatCard(label: 'BMI', value: MockData.bodyMassIndex),
              const SizedBox(height: 12),
              _StatCard(label: 'Gender', value: MockData.userGender),
              const SizedBox(height: 12),
              _StatCard(label: 'Date of Birth', value: MockData.userDateOfBirth),
              const SizedBox(height: 32),
              PrimaryActionButton(
                label: 'Edit Body Stats',
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EditProfileScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: AppTextStyles.settingsItem),
          ),
          Text(value, style: AppTextStyles.settingsValue),
        ],
      ),
    );
  }
}
