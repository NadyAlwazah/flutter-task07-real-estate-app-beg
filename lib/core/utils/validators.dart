class Validators {
  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Name is required";
    }
    if (value.trim().length < 2) {
      return "Name is too short";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    if (!value.contains("@")) {
      return "Enter a valid email";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }
    return null;
  }
}
