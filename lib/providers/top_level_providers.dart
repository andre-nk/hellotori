part of "providers.dart";

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authStateChangesProvider = StreamProvider<User?>(
    (ref) => ref.watch(firebaseAuthProvider).authStateChanges());

final databaseProvider = Provider<FirestoreDatabase>((ref) => FirestoreDatabase());

final storageProvider = Provider<StorageService>((ref) => StorageService());

final eventStreamProvider = StreamProvider.autoDispose<List<Event>>((ref) {
  final database = ref.watch(databaseProvider);
  return database.eventList;
});

final schoolStreamProvider = StreamProvider.autoDispose<Bios>((ref){
  final database = ref.watch(databaseProvider);
  return database.schoolArticle;
});

final osisStreamProvider = StreamProvider.autoDispose<Bios>((ref){
  final database = ref.watch(databaseProvider);
  return database.osisArticle;
});

final mainUserStreamProvider = StreamProvider.family<MainUser, String>((ref, uid){
  final database = ref.watch(databaseProvider);
  return database.mainUserProfile(uid);
});

final onboardingViewModelProvider = StateNotifierProvider<OnboardingViewModel>((ref) {
  final sharedPreferencesService = ref.watch(sharedPreferencesServiceProvider);
  return OnboardingViewModel(sharedPreferencesService);
});

final authModelProvider = ChangeNotifierProvider<AuthenticationViewModel>(
  (ref) => AuthenticationViewModel(auth: ref.watch(firebaseAuthProvider)),
);