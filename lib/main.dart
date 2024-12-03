import 'package:Checkmate/utils/routes/navigation_provider.dart';
import 'package:Checkmate/utils/routes/route.dart';
import 'package:Checkmate/utils/themes/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


Future<void> main() async {



  runApp(
      const ProviderScope(child: MyApp()) // using riverpod state management
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final themeNotifier = ref.watch(themeNotifierProvider); // theme notifier initializes to load the theme for the user
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.currentTheme,
      navigatorKey: ref.watch(navigationProvider).navigatorKey,
      onGenerateRoute: Routes.generateRoute,
      initialRoute: Routes.homeScreen, // initial route to homePage
    );
  }




}
