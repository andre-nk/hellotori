part of "providers.dart";
class OnboardingViewModel extends StateNotifier<bool> {
  OnboardingViewModel(this.sharedPreferencesService)
      : super(sharedPreferencesService.isOnboardingComplete());
  final SharedPreferencesService sharedPreferencesService;

  Future<void> completeOnboarding() async {
    await sharedPreferencesService.setOnboardingComplete();
    state = true;
  }

  Future<void> cancelCompleteOnboarding() async {
    await sharedPreferencesService.cancelOnboardingComplete();
    state = false;
  }

  Future<void> setFirestoreLiveKey(String keyID) async{
    await sharedPreferencesService.setActivityIntents(keyID);
  }

  String get firestoreLiveKey => sharedPreferencesService.firestoreKey;
  bool get isOnboardingComplete => state;
}