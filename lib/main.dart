import 'package:event_palnning_project/firebase/firebase_manager.dart';
import 'package:event_palnning_project/providers/app_theme_provider.dart';
import 'package:event_palnning_project/providers/create_event_provider.dart';
import 'package:event_palnning_project/providers/user_provider.dart';
import 'package:event_palnning_project/screens/auth/login/login_screen.dart';
import 'package:event_palnning_project/screens/auth/register/register.dart';
import 'package:event_palnning_project/screens/homescreen.dart';
import 'package:event_palnning_project/screens/letsgo.dart';
import 'package:event_palnning_project/screens/onboarding.dart';
import 'package:event_palnning_project/screens/tabs/home/add_event/add_event.dart';
import 'package:event_palnning_project/screens/tabs/home/event_details/event_details_screen.dart';
import 'package:event_palnning_project/style/app_theme.dart';
import 'package:easy_localization/easy_localization.dart'; // Import Easy Localization package
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cache/cache_helper.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [
        const Locale('en'),
        const Locale('ar'),
      ], // Define supported locales
      path: 'assets/translations', // Path to your translation files
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AppThemeProvider()),
          ChangeNotifierProvider(create: (context) => CreateEventsProvider()),
          ChangeNotifierProvider(create: (context) => UserProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: userProvider.firebaseUser == null
          ? LetsGo.routeName
          : Homescreen.routeName,
      routes: {
        LetsGo.routeName: (context) => LetsGo(),
        OnboardingScreen.routeName: (context) => OnboardingScreen(),
        Homescreen.routeName: (context) => Homescreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        AddEvent.routeName: (context) => AddEvent(),
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,
      locale: context.locale,
      // Set the app locale from EasyLocalization
      localizationsDelegates: context.localizationDelegates,
      // Localization delegates
      supportedLocales: context.supportedLocales, // Supported locales
    );
  }
}
