import 'package:flutter/material.dart';
import 'package:flutter_coffeee/core/constants/app_constants.dart';
import 'package:flutter_coffeee/core/mock/mock_data.dart';
import 'package:flutter_coffeee/core/theme/app_colors.dart';
import 'package:flutter_coffeee/core/theme/app_text_styles.dart';

class HomeView extends StatelessWidget {
  final ValueChanged<int> onSwitchTab;

  const HomeView({super.key, required this.onSwitchTab});

  @override
  Widget build(BuildContext context) {
    final activeGoals = MockData.activeGoalsLabel;

    return Scaffold(
      backgroundColor: AppColors.backgroundAlt,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.screenHorizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text(
                'Welcome back,',
                style: AppTextStyles.aboutDescription,
              ),
              Text(
                MockData.userFullName.split(' ').first,
                style: AppTextStyles.profileName,
              ),
              const SizedBox(height: 8),
              if (activeGoals.isNotEmpty)
                Text(
                  'Focus: $activeGoals',
                  style: AppTextStyles.membershipBadge.copyWith(
                    color: AppColors.textSecondary,
                    letterSpacing: 0,
                  ),
                ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: _QuickStatCard(
                      label: 'This Week',
                      value: '${MockData.weeklyWorkoutCount}',
                      subtitle: 'workouts',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _QuickStatCard(
                      label: 'Total',
                      value: '${MockData.totalWorkouts}',
                      subtitle: 'sessions',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text('Quick Actions', style: AppTextStyles.sectionHeader),
              const SizedBox(height: 12),
              _ActionTile(
                icon: Icons.fitness_center,
                title: 'Start Workout',
                subtitle: 'Browse preset programs',
                onTap: () => onSwitchTab(1),
              ),
              const SizedBox(height: 12),
              _ActionTile(
                icon: Icons.format_list_bulleted,
                title: 'Exercise Library',
                subtitle: 'Explore exercises and favorites',
                onTap: () => onSwitchTab(2),
              ),
              const SizedBox(height: 12),
              _ActionTile(
                icon: Icons.bar_chart_outlined,
                title: 'View Progress',
                subtitle: 'Track completed sessions',
                onTap: () => onSwitchTab(3),
              ),
              const SizedBox(height: 12),
              _ActionTile(
                icon: Icons.person_outline,
                title: 'Edit Profile',
                subtitle: 'Update your personal info',
                onTap: () => onSwitchTab(4),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickStatCard extends StatelessWidget {
  final String label;
  final String value;
  final String subtitle;

  const _QuickStatCard({
    required this.label,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardColorAlt,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.inputLabel),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.profileName.copyWith(fontSize: 28),
          ),
          Text(subtitle, style: AppTextStyles.settingsValue),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cardColorAlt,
      borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.accentColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppColors.accentColor),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.menuItem.copyWith(fontSize: 16)),
                    Text(subtitle, style: AppTextStyles.settingsValue),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}
