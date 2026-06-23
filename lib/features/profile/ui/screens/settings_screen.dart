import 'package:flutter/material.dart';
import 'package:flutter_coffeee/core/constants/app_constants.dart';
import 'package:flutter_coffeee/core/theme/app_colors.dart';
import 'package:flutter_coffeee/features/profile/ui/widgets/logout_button.dart';
import 'package:flutter_coffeee/features/profile/ui/widgets/profile_screen_header.dart';
import 'package:flutter_coffeee/features/profile/ui/widgets/settings_section.dart';
import 'package:flutter_coffeee/features/profile/ui/widgets/settings_tile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkModeEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.screenHorizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const ProfileScreenHeader(
                title: 'Settings',
                useLargeTitle: true,
              ),
              const SizedBox(height: 8),
              SettingsSection(
                title: 'Preferences',
                children: [
                  SettingsTile(
                    title: 'Units',
                    trailingText: AppConstants.unitsValue,
                    onTap: () {},
                  ),
                  SettingsTile(
                    title: 'Workout Reminders',
                    trailingText: AppConstants.workoutRemindersValue,
                    onTap: () {},
                  ),
                  SettingsTile(
                    title: 'Rest Timer',
                    trailingText: AppConstants.restTimerValue,
                    onTap: () {},
                  ),
                  SettingsTile(
                    title: 'Dark Mode',
                    showDivider: false,
                    trailing: SettingsToggle(value: _darkModeEnabled),
                    onTap: () {
                      setState(() => _darkModeEnabled = !_darkModeEnabled);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SettingsSection(
                title: 'Account',
                children: [
                  SettingsTile(
                    title: 'Change Password',
                    onTap: () {},
                  ),
                  SettingsTile(
                    title: 'Privacy Policy',
                    onTap: () {},
                  ),
                  SettingsTile(
                    title: 'Terms of Service',
                    showDivider: false,
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 16),
              LogoutButton(onPressed: () {}),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
