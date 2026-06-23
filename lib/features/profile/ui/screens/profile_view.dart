import 'package:flutter/material.dart';
import 'package:flutter_coffeee/core/constants/app_constants.dart';
import 'package:flutter_coffeee/core/state/app_state.dart';
import 'package:flutter_coffeee/core/theme/app_colors.dart';
import 'package:flutter_coffeee/core/theme/app_text_styles.dart';
import 'package:flutter_coffeee/core/utils/session_actions.dart';
import 'package:flutter_coffeee/features/profile/ui/screens/about_us_screen.dart';
import 'package:flutter_coffeee/features/profile/ui/screens/body_stats_screen.dart';
import 'package:flutter_coffeee/features/profile/ui/screens/edit_profile_screen.dart';
import 'package:flutter_coffeee/features/profile/ui/screens/goals_screen.dart';
import 'package:flutter_coffeee/features/profile/ui/screens/help_support_screen.dart';
import 'package:flutter_coffeee/features/profile/ui/screens/settings_screen.dart';
import 'package:flutter_coffeee/features/profile/ui/widgets/logout_button.dart';
import 'package:flutter_coffeee/features/profile/ui/widgets/membership_badge.dart';
import 'package:flutter_coffeee/features/profile/ui/widgets/profile_avatar.dart';
import 'package:flutter_coffeee/features/profile/ui/widgets/profile_menu_tile.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState.instance,
      builder: (context, _) {
        final profile = AppState.instance.profile;

        return Scaffold(
          backgroundColor: AppColors.backgroundAlt,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.screenHorizontalPadding,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EditProfileScreen(),
                      ),
                    ),
                    child: ProfileAvatar(imageUrl: profile.imageUrl),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    profile.fullName,
                    style: AppTextStyles.profileName,
                  ),
                  const SizedBox(height: 4),
                  const MembershipBadge(),
                  const SizedBox(height: 32),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.cardColorAlt,
                      borderRadius: BorderRadius.circular(
                        AppConstants.cardBorderRadius,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        ProfileMenuTile(
                          icon: Icons.person_outline,
                          title: 'Body Stats',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const BodyStatsScreen(),
                            ),
                          ),
                        ),
                        const Divider(height: 1, color: AppColors.dividerColor),
                        ProfileMenuTile(
                          icon: Icons.check_circle_outline,
                          title: 'Goals',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const GoalsScreen(),
                            ),
                          ),
                        ),
                        const Divider(height: 1, color: AppColors.dividerColor),
                        ProfileMenuTile(
                          icon: Icons.settings_outlined,
                          title: 'Settings',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SettingsScreen(),
                            ),
                          ),
                        ),
                        const Divider(height: 1, color: AppColors.dividerColor),
                        ProfileMenuTile(
                          icon: Icons.help_outline,
                          title: 'Help & Support',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HelpSupportScreen(),
                            ),
                          ),
                        ),
                        const Divider(height: 1, color: AppColors.dividerColor),
                        ProfileMenuTile(
                          icon: Icons.info_outline,
                          title: 'About Us',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AboutUsScreen(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  LogoutButton(
                    isProfileStyle: true,
                    onPressed: () => SessionActions.logout(context),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
