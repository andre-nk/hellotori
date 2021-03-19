part of "../pages.dart";

class AuthWidget extends ConsumerWidget {
  final WidgetBuilder? nonSignedInBuilder;
  final WidgetBuilder? signedInBuilder;

  AuthWidget({this.nonSignedInBuilder, this.signedInBuilder});
  
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final authStateChanges = watch(authStateChangesProvider);
    return authStateChanges.when(
      data: (user) => _data(context, user!),
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (_, __) => const Scaffold(
        body: Text("error")
      ),
    );
  }

  Widget _data(BuildContext context, User user) {
    // ignore: unnecessary_null_comparison
    if (user != null) {
      return signedInBuilder!(context);
    }
    return nonSignedInBuilder!(context);
  }
}