part of "services.dart";

final sharedPreferencesServiceProvider = Provider<SharedPreferencesService>((ref) => throw UnimplementedError());
class SharedPreferencesService {
  SharedPreferencesService(this.sharedPreferences);
  final SharedPreferences sharedPreferences;

  static const onboardingCompleteKey = 'onboardingComplete';
  static const firestoreLiveKey = 'firestoreLiveKey';

  String get firestoreKey => sharedPreferences.getString(firestoreLiveKey) ?? "";

  Future<void> setActivityIntents(String keyID) async{
    await sharedPreferences.setString(firestoreLiveKey, keyID);
  }

  Future<void> setOnboardingComplete() async {
    await sharedPreferences.setBool(onboardingCompleteKey, true);
  }

  Future<void> cancelOnboardingComplete() async {
    await sharedPreferences.setBool(onboardingCompleteKey, false);
  }

  bool isOnboardingComplete() =>
      sharedPreferences.getBool(onboardingCompleteKey) ?? false;
}