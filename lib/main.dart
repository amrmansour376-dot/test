import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffeee/core/services/workout_services.dart';
import 'package:flutter_coffeee/core/state/app_state.dart';
import 'package:flutter_coffeee/core/theme/app_theme.dart';
import 'package:flutter_coffeee/features/root_view.dart';
import 'package:flutter_coffeee/features/workouts/data/repositories/workout_repo.dart';
import 'package:flutter_coffeee/features/workouts/ui/cubit/workout_day_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://wzsyiwzytaesllibgdvf.supabase.co',
    anonKey: 'sb_publishable_snp99wIVMB_g_Yvf1Rg2UA_paOac786',
  );

  runApp(
    ListenableBuilder(
      listenable: AppState.instance,
      builder: (context, _) {
        final settings = AppState.instance.settings;
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  WorkoutDayCubit(WorkoutRepositoryImpl(WorkoutServices())),
            ),
          ],
          child: MyApp(darkModeEnabled: settings.darkModeEnabled),
        );
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool darkModeEnabled;

  const MyApp({super.key, required this.darkModeEnabled});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: darkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      home: const RootView(),
    );
  }
}
