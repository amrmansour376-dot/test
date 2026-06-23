import 'package:flutter/material.dart';
import 'package:flutter_coffeee/core/constants/app_constants.dart';
import 'package:flutter_coffeee/core/theme/app_colors.dart';
import 'package:flutter_coffeee/core/theme/app_text_styles.dart';
import 'package:flutter_coffeee/features/profile/ui/widgets/profile_screen_header.dart';

class LegalDocumentScreen extends StatelessWidget {
  final String title;
  final String content;

  const LegalDocumentScreen({
    super.key,
    required this.title,
    required this.content,
  });

  factory LegalDocumentScreen.privacy() {
    return const LegalDocumentScreen(
      title: 'Privacy Policy',
      content:
          'We respect your privacy. This app stores profile, settings, and workout '
          'progress locally on your device for demonstration purposes. '
          'Workout program data may be loaded from Supabase when available. '
          'We do not sell personal data. Contact support@gymapp.com for questions.',
    );
  }

  factory LegalDocumentScreen.terms() {
    return const LegalDocumentScreen(
      title: 'Terms of Service',
      content:
          'By using Gym App you agree to train responsibly and consult a physician '
          'before starting any fitness program. Content is provided for informational '
          'purposes. You are responsible for using equipment safely and maintaining '
          'accurate profile information.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.screenHorizontalPadding,
                vertical: 16,
              ),
              child: ProfileScreenHeader(title: title),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.screenHorizontalPadding,
                ),
                child: Text(
                  content,
                  style: AppTextStyles.aboutDescription,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
