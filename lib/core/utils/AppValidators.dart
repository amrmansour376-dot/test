
class AppValidators {
  const AppValidators._();

  /// Email Validator
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    final cleanValue = value.trim();

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(cleanValue)) {
      return "Invalid email address";
    }

    return null;
  }

  /// Password Validator
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }

    final passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*[0-9])');
    if (!passwordRegExp.hasMatch(value)) {
      return "Password Very Weak";
    }

    return null;
  }

  static String? confirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return "Confirm password is required";
    }
    if (value != password) {
      return "Passwords do not match";
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Phone number is required";
    }
    String phone = value.trim();
    if (phone.length != 11) {
      return "Invalid phone number";
    }
    return null;
  }

  static String? requiredField(String? value, {String label = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$label is required';
    }
    return null;
  }

  static String? fullName(String? value) {
    final requiredResult = requiredField(value, label: 'Full name');
    if (requiredResult != null) return requiredResult;

    if (value!.trim().length < 2) {
      return 'Full name is too short';
    }
    return null;
  }

  static String? height(String? value) {
    final requiredResult = requiredField(value, label: 'Height');
    if (requiredResult != null) return requiredResult;

    final digits = RegExp(r'\d+').stringMatch(value!.trim());
    if (digits == null) {
      return 'Enter height with a number (e.g. 180 cm)';
    }
    return null;
  }

  static String? weight(String? value) {
    final requiredResult = requiredField(value, label: 'Weight');
    if (requiredResult != null) return requiredResult;

    final digits = RegExp(r'\d+').stringMatch(value!.trim());
    if (digits == null) {
      return 'Enter weight with a number (e.g. 78 kg)';
    }
    return null;
  }

  static String? dateOfBirth(String? value) {
    return requiredField(value, label: 'Date of birth');
  }
}
