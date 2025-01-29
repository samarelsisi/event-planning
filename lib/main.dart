import 'package:event_palnning_project/providers/app_theme_provider.dart';
import 'package:event_palnning_project/screens/homescreen.dart';
import 'package:event_palnning_project/screens/letsgo.dart';
import 'package:event_palnning_project/screens/onboarding.dart';
import 'package:event_palnning_project/style/app_theme.dart';
import 'package:easy_localization/easy_localization.dart'; // Import Easy Localization package
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cache/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  WidgetsFlutterBinding.ensureInitialized();

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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LetsGo.routeName,
      routes: {
        LetsGo.routeName: (context) => LetsGo(),
        OnboardingScreen.routeName: (context) => OnboardingScreen(),
        Homescreen.routeName: (context) => Homescreen()
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
