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

  bool get isOnboardingComplete => state;
}