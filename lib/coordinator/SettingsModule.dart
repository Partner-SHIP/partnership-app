import 'package:partnership/style/theme.dart';

class SettingsModule {
  static final SettingsModule _instance = SettingsModule._internal();
  factory SettingsModule() {
    return _instance;
  }
  SettingsModule._internal(){
  }
  final AppTheme themeSelected = AThemes.selectedTheme;
}