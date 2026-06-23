import 'package:flutter/material.dart';
import 'package:flutter_coffeee/core/constants/app_constants.dart';
import 'package:flutter_coffeee/core/theme/app_colors.dart';
import 'package:flutter_coffeee/features/profile/ui/widgets/gender_dropdown_field.dart';
import 'package:flutter_coffeee/features/profile/ui/widgets/labeled_input_field.dart';
import 'package:flutter_coffeee/features/profile/ui/widgets/primary_action_button.dart';
import 'package:flutter_coffeee/features/profile/ui/widgets/profile_avatar.dart';
import 'package:flutter_coffeee/features/profile/ui/widgets/profile_screen_header.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _heightController;
  late final TextEditingController _weightController;
  late final TextEditingController _dobController;
  late String _selectedGender;

  @override
  void initState() {
    super.initState();
    _fullNameController =
        TextEditingController(text: AppConstants.userFullName);
    _emailController = TextEditingController(text: AppConstants.userEmail);
    _heightController = TextEditingController(text: AppConstants.userHeight);
    _weightController = TextEditingController(text: AppConstants.userWeight);
    _dobController =
        TextEditingController(text: AppConstants.userDateOfBirth);
    _selectedGender = AppConstants.userGender;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _onSave() {
    Navigator.pop(context);
  }

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
              const ProfileScreenHeader(title: 'Edit Profile'),
              const SizedBox(height: 32),
              ProfileAvatar(
                imageUrl: AppConstants.editProfileImageUrl,
                size: AppConstants.editProfileAvatarSize,
                showCameraBadge: true,
                onCameraTap: () {},
              ),
              const SizedBox(height: 32),
              LabeledInputField(
                label: 'Full Name',
                controller: _fullNameController,
              ),
              const SizedBox(height: 16),
              LabeledInputField(
                label: 'Email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: LabeledInputField(
                      label: 'Height',
                      controller: _heightController,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: LabeledInputField(
                      label: 'Weight',
                      controller: _weightController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              LabeledInputField(
                label: 'Date of Birth',
                controller: _dobController,
              ),
              const SizedBox(height: 16),
              GenderDropdownField(
                value: _selectedGender,
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedGender = value);
                  }
                },
              ),
              const SizedBox(height: 24),
              PrimaryActionButton(
                label: 'Save Changes',
                onPressed: _onSave,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
