import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hellotori/providers/providers.dart';
import 'package:hellotori/services/services.dart';
import 'package:hellotori/views/pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final sharedPreferences = await SharedPreferences.getInstance();
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
            final didCompleteOnboarding =
                watch(onboardingViewModelProvider.state);
            return didCompleteOnboarding ? AuthPage() : OnboardingPages();
          },
        ),
        signedInBuilder: (_) => EventPage(),
      ),
    );
  }
}