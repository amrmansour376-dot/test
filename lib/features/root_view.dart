import 'package:flutter/material.dart';
import 'package:flutter_coffeee/core/state/app_state.dart';
import 'package:flutter_coffeee/core/theme/app_color.dart';
import 'package:flutter_coffeee/features/exercises/ui/screens/exercise_view.dart';
import 'package:flutter_coffeee/features/home/ui/screens/home_view.dart';
import 'package:flutter_coffeee/features/profile/ui/screens/profile_view.dart';
import 'package:flutter_coffeee/features/progress/ui/screens/progress_view.dart';
import 'package:flutter_coffeee/features/workouts/ui/screens/workouts_view.dart';

class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  final PageController controller = PageController();
  int indexScreen = 0;

  final List<Widget> screens = const [
    HomeView(),
    WorkoutsView(),
    ExerciseView(),
    ProgressView(),
    ProfileView(),
  ];

  @override
  void initState() {
    super.initState();
    AppState.instance.addListener(_onAppStateChanged);
    indexScreen = AppState.instance.rootTabIndex;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.hasClients && indexScreen != 0) {
        controller.jumpToPage(indexScreen);
      }
    });
  }

  @override
  void dispose() {
    AppState.instance.removeListener(_onAppStateChanged);
    controller.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    AppState.instance.switchTab(index);
  }

  void _onAppStateChanged() {
    final targetIndex = AppState.instance.rootTabIndex;
    if (targetIndex == indexScreen) return;
    setState(() => indexScreen = targetIndex);
    if (controller.hasClients) {
      controller.animateToPage(
        targetIndex,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) => setState(() => indexScreen = value),
        children: screens,
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
      onPressed: () => _onItemTapped(index),
    );
  }
}
