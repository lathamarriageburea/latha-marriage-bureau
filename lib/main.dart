import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/home/screens/home_screen.dart';
//import 'features/admin/screens/admin_profiles_screen.dart';
//import 'features/admin/screens/admin_dashboard_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const LathaMarriageBureauApp());
}

class LathaMarriageBureauApp extends StatelessWidget {
  const LathaMarriageBureauApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Latha Marriage Bureau',
      theme: AppTheme.lightTheme,
      //home: const AdminProfilesScreen(),
      home: const HomeScreen(),
    );
  }
}