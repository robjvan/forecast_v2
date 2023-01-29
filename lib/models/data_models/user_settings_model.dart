class UserSettings {
  final bool useDarkMode;
  final bool useDynamicBackgrounds;
  final String userColor;

  UserSettings({
    required this.useDarkMode,
    required this.useDynamicBackgrounds,
    required this.userColor,
  });

  factory UserSettings.initial() {
    return UserSettings(
      useDarkMode: false,
      useDynamicBackgrounds: true,
      userColor: '00FF00',
    );
  }
}
