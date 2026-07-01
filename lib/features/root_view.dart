import 'package:flutter/material.dart';
import 'package:flutter_coffeee/core/theme/app_color.dart';
import 'package:flutter_coffeee/core/ui/app_ui_bridge.dart';
import 'package:flutter_coffeee/features/exercises/ui/screens/exercise_view.dart';
import 'package:flutter_coffeee/features/home/ui/screens/home_view.dart';
import 'package:flutter_coffeee/features/profile/ui/screens/profile_view.dart';
import 'package:flutter_coffeee/features/progress/ui/screens/progress_view.dart';
import 'package:flutter_coffeee/features/workouts/ui/screens/workouts_view.dart';

class RootView extends StatefulWidget {
  final bool darkModeEnabled;
  final ValueChanged<bool> onDarkModeChanged;

  const RootView({
    super.key,
    required this.darkModeEnabled,
    required this.onDarkModeChanged,
  });

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  final PageController controller = PageController();
  int indexScreen = 0;

  @override
  void initState() {
    super.initState();
    AppUIBridge.switchTab = _switchTab;
  }

  @override
  void dispose() {
    if (AppUIBridge.switchTab == _switchTab) {
      AppUIBridge.switchTab = null;
    }
    controller.dispose();
    super.dispose();
  }

  void _switchTab(int index) {
    if (index == indexScreen) return;
    setState(() => indexScreen = index);
    if (controller.hasClients) {
      controller.animateToPage(
        index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeView(onSwitchTab: _switchTab),
      const WorkoutsView(),
      ExerciseView(onSwitchTab: _switchTab),
      const ProgressView(),
      ProfileView(
        darkModeEnabled: widget.darkModeEnabled,
        onDarkModeChanged: widget.onDarkModeChanged,
      ),
    ];

    return Scaffold(
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) => setState(() => indexScreen = value),
        children: pages,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(
          color: AppColors.cardColor,
          border: Border(
            top: BorderSide(color: Color(0xff2C2C2E), width: 0.5),
          ),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_outlined, 0),
              _buildNavItem(Icons.fitness_center, 1),
              _buildNavItem(Icons.format_list_bulleted, 2),
              _buildNavItem(Icons.bar_chart_outlined, 3),
              _buildNavItem(Icons.person_outline, 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final bool isSelected = indexScreen == index;
    return IconButton(
      icon: Icon(
        icon,
        color: isSelected ? AppColors.accentColor : AppColors.textSecondary,
        size: isSelected ? 33 : 26,
      ),
      onPressed: () => _switchTab(index),
    );
  }
}
