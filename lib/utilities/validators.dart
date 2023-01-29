class AppValidators {
  static dynamic sixDigitValidator(final String value, final String field) {
    if (value.length < 6) {
      return '$field is too short!';
    }
    return null;
  }

  static dynamic emailValidator(final String value) {
    if (value.length < 6) {
      return 'Must use valid email format';
    }
    return null;
  }
}
