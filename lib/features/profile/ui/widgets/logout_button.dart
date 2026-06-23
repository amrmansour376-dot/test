import 'package:flutter/material.dart';
import 'package:flutter_coffeee/core/constants/app_constants.dart';
import 'package:flutter_coffeee/core/theme/app_colors.dart';
import 'package:flutter_coffeee/core/theme/app_text_styles.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isProfileStyle;

  const LogoutButton({
    super.key,
    this.onPressed,
    this.isProfileStyle = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: BorderSide(
            color: isProfileStyle
                ? AppColors.logoutRed
                : AppColors.logoutBorder,
          ),
          backgroundColor:
              isProfileStyle ? Colors.transparent : AppColors.logoutBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppConstants.buttonBorderRadius,
            ),
          ),
        ),
        child: Text(
          'Log Out',
          style: isProfileStyle
              ? AppTextStyles.logoutButtonProfile
              : AppTextStyles.logoutButton,
        ),
      ),
    );
  }
}
