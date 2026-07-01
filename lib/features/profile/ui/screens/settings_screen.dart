import 'package:flutter/material.dart';
import 'package:flutter_coffeee/core/constants/app_constants.dart';
import 'package:flutter_coffeee/core/mock/mock_data.dart';
import 'package:flutter_coffeee/core/theme/app_colors.dart';
import 'package:flutter_coffeee/core/utils/app_dialogs.dart';
import 'package:flutter_coffeee/core/utils/app_snackbars.dart';
import 'package:flutter_coffeee/core/utils/session_actions.dart';
import 'package:flutter_coffeee/features/profile/ui/screens/change_password_screen.dart';
import 'package:flutter_coffeee/features/profile/ui/screens/legal_document_screen.dart';
import 'package:flutter_coffeee/features/profile/ui/widgets/logout_button.dart';
import 'package:flutter_coffeee/features/profile/ui/widgets/profile_screen_header.dart';
import 'package:flutter_coffeee/features/profile/ui/widgets/settings_section.dart';
import 'package:flutter_coffeee/features/profile/ui/widgets/settings_tile.dart';

class SettingsScreen extends StatefulWidget {
  final bool darkModeEnabled;
  final ValueChanged<bool> onDarkModeChanged;

  const SettingsScreen({
    super.key,
    required this.darkModeEnabled,
    required this.onDarkModeChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String _units;
  late bool _workoutRemindersEnabled;
  late String _workoutReminderTime;
  late int _restTimerSeconds;

  @override
  void initState() {
    super.initState();
    _units = MockData.units;
    _workoutRemindersEnabled = MockData.workoutRemindersEnabled;
    _workoutReminderTime = MockData.workoutReminderTime;
    _restTimerSeconds = MockData.restTimerSeconds;
  }

  String get _restTimerLabel => '$_restTimerSeconds sec';

  String get _workoutRemindersLabel => _workoutRemindersEnabled
      ? 'On · $_workoutReminderTime'
      : 'Off';

  Future<void> _pickUnits() async {
    const options = ['Metric (kg, cm)', 'Imperial (lb, ft)'];
    final selected = await AppDialogs.showOptionsSheet(
      context,
      title: 'Units',
      options: options,
      selected: _units,
    );
    if (selected == null || !mounted) return;

    setState(() => _units = selected);
    AppSnackbars.showSuccess(context, 'Units updated');
  }

  Future<void> _configureReminders() async {
    final enabled = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Workout Reminders'),
        content: SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Enable reminders'),
          value: _workoutRemindersEnabled,
          activeThumbColor: AppColors.accentColor,
          onChanged: (value) => Navigator.pop(context, value),
        ),
      ),
    );

    if (enabled == null || !mounted) return;

    var reminderTime = _workoutReminderTime;
    if (enabled) {
      final parts = reminderTime.split(' ');
      final timeParts = parts.first.split(':');
      final initial = TimeOfDay(
        hour: int.tryParse(timeParts.first) ?? 7,
        minute: int.tryParse(timeParts.last) ?? 0,
      );
      final picked = await AppDialogs.pickReminderTime(context, initial);
      if (picked != null) {
        final hour = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
        final period = picked.period == DayPeriod.am ? 'AM' : 'PM';
        reminderTime = '$hour:${picked.minute.toString().padLeft(2, '0')} $period';
      }
    }

    if (!mounted) return;
    setState(() {
      _workoutRemindersEnabled = enabled;
      _workoutReminderTime = reminderTime;
    });
    AppSnackbars.showSuccess(context, 'Reminder settings updated');
  }

  Future<void> _pickRestTimer() async {
    const options = ['30 sec', '45 sec', '60 sec', '90 sec'];
    final selected = await AppDialogs.showOptionsSheet(
      context,
      title: 'Rest Timer',
      options: options,
      selected: _restTimerLabel,
    );
    if (selected == null || !mounted) return;

    final seconds = int.parse(selected.split(' ').first);
    setState(() => _restTimerSeconds = seconds);
    AppSnackbars.showSuccess(context, 'Rest timer updated');
  }

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
                    trailingText: _units,
                    onTap: _pickUnits,
                  ),
                  SettingsTile(
                    title: 'Workout Reminders',
                    trailingText: _workoutRemindersLabel,
                    onTap: _configureReminders,
                  ),
                  SettingsTile(
                    title: 'Rest Timer',
                    trailingText: _restTimerLabel,
                    onTap: _pickRestTimer,
                  ),
                  SettingsTile(
                    title: 'Dark Mode',
                    showDivider: false,
                    trailing: SettingsToggle(value: widget.darkModeEnabled),
                    onTap: () {
                      widget.onDarkModeChanged(!widget.darkModeEnabled);
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
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ChangePasswordScreen(),
                      ),
                    ),
                  ),
                  SettingsTile(
                    title: 'Privacy Policy',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LegalDocumentScreen.privacy(),
                      ),
                    ),
                  ),
                  SettingsTile(
                    title: 'Terms of Service',
                    showDivider: false,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LegalDocumentScreen.terms(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              LogoutButton(
                onPressed: () => SessionActions.logout(context),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
