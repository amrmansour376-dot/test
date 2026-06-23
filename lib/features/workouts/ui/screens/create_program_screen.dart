import 'package:flutter/material.dart';
import 'package:flutter_coffeee/core/constants/app_constants.dart';
import 'package:flutter_coffeee/core/state/app_state.dart';
import 'package:flutter_coffeee/core/theme/app_colors.dart';
import 'package:flutter_coffeee/core/utils/AppValidators.dart';
import 'package:flutter_coffeee/core/utils/app_snackbars.dart';
import 'package:flutter_coffeee/features/profile/ui/widgets/labeled_input_field.dart';
import 'package:flutter_coffeee/features/profile/ui/widgets/primary_action_button.dart';
import 'package:flutter_coffeee/features/profile/ui/widgets/profile_screen_header.dart';

class CreateProgramScreen extends StatefulWidget {
  const CreateProgramScreen({super.key});

  @override
  State<CreateProgramScreen> createState() => _CreateProgramScreenState();
}

class _CreateProgramScreenState extends State<CreateProgramScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  int _daysPerWeek = 3;
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _createProgram() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    await Future<void>.delayed(const Duration(milliseconds: 700));

    AppState.instance.addCustomProgram(
      CustomProgram(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        daysPerWeek: _daysPerWeek,
        createdAt: DateTime.now(),
      ),
    );

    if (!mounted) return;
    setState(() => _isSaving = false);
    AppSnackbars.showSuccess(context, 'Program created successfully');
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfileScreenHeader(title: 'Create Program'),
                const SizedBox(height: 32),
                LabeledInputField(
                  label: 'Program Name',
                  controller: _nameController,
                  validator: (value) =>
                      AppValidators.requiredField(value, label: 'Program name'),
                ),
                const SizedBox(height: 16),
                LabeledInputField(
                  label: 'Description',
                  controller: _descriptionController,
                  validator: (value) => AppValidators.requiredField(
                    value,
                    label: 'Description',
                  ),
                ),
                const SizedBox(height: 16),
                Text('Days Per Week', style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 8),
                DropdownButtonFormField<int>(
                  value: _daysPerWeek,
                  dropdownColor: AppColors.inputBackground,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.inputBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: List.generate(
                    6,
                    (index) => DropdownMenuItem(
                      value: index + 2,
                      child: Text('${index + 2} days'),
                    ),
                  ),
                  onChanged: (value) {
                    if (value != null) setState(() => _daysPerWeek = value);
                  },
                ),
                const SizedBox(height: 24),
                PrimaryActionButton(
                  label: 'Create Program',
                  isLoading: _isSaving,
                  onPressed: _createProgram,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
