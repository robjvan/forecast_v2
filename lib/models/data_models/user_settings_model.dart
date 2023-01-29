class UserSettings {
  bool? useDarkMode;
  bool? useDynamicBackgrounds;
  String? userColor;

  UserSettings({
    this.useDarkMode,
    this.useDynamicBackgrounds,
    this.userColor,
  });

  factory UserSettings.initial() {
    return UserSettings(
      useDarkMode: false,
      useDynamicBackgrounds: true,
      userColor: '00FF00',
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'useDarkMode': useDarkMode,
        'useDynamicBackgrounds': useDynamicBackgrounds,
        'userColor': userColor,
      };
}
