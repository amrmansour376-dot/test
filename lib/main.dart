import 'package:flutter/material.dart';
import 'package:flutter_coffeee/core/theme/app_theme.dart';
import 'package:flutter_coffeee/features/root_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _darkModeEnabled = true;

  void _setDarkMode(bool enabled) {
    setState(() => _darkModeEnabled = enabled);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _darkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      home: RootView(
        onDarkModeChanged: _setDarkMode,
        darkModeEnabled: _darkModeEnabled,
      ),
    );
  }
}
