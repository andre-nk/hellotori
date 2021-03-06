import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hellotori/configs/configs.dart';
import 'package:hellotori/providers/providers.dart';
import 'package:hellotori/services/services.dart';
import 'package:hellotori/views/pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //firebase
  await Firebase.initializeApp();

  //sharedpref
  final sharedPreferences = await SharedPreferences.getInstance();

  //appbar override
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Palette.black,
    statusBarColor: Palette.blueAccent, // status bar color
  ));
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //local notification
  var initializationSettingsAndroid = AndroidInitializationSettings('splash');
  var initializationSettingsIOS = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid, 
    iOS: initializationSettingsIOS
  );
  await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
  );

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesServiceProvider.overrideWithValue(
          SharedPreferencesService(sharedPreferences),
        ),
      ],
      child: InitialPage(),
    )
  );
}

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: Palette.blueAccent
      ),
      initialRoute: '/',
      routes: {
        '/auth': (context) => AuthPage(),
        '/eventpage': (context) => EventPage(),
      },
      debugShowCheckedModeBanner: false,
      title: "hellotori",
      home: AuthWidget(
        nonSignedInBuilder: (_) => Consumer(
          builder: (context, watch, _) {
            final didCompleteOnboarding = watch(onboardingViewModelProvider.state);
            return didCompleteOnboarding ?  AuthPage() : OnboardingPages();
          },
        ),
        signedInBuilder: (_) => EventPage(),
      ),
    );
  }
}
