import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:project_demo_t/core/routes/routes.dart';
import 'package:project_demo_t/provider/provider.dart';
import 'package:project_demo_t/screen/anime_screen.dart';
import 'package:provider/provider.dart';
import 'core/utils/preference.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: AnimeScreen(),
        initialRoute: Routes.splashScreen,
        onGenerateRoute: RouteGenerator.generateRoute,
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
      ),
    );
  }
}
