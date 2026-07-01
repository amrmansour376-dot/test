/// Lightweight UI wiring helpers for cross-widget callbacks (no state packages).
class AppUIBridge {
  AppUIBridge._();

  static void Function(int index)? switchTab;
  static void Function(bool enabled)? setDarkMode;
}
