part of "../pages.dart";

class AuthWidget extends ConsumerWidget {
  final WidgetBuilder nonSignedInBuilder;
  final WidgetBuilder signedInBuilder;

  AuthWidget({required this.nonSignedInBuilder, required this.signedInBuilder});
  
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final authStateChanges = watch(authStateChangesProvider);
    return authStateChanges.when(
      data: (user){
        return user != null
          ? signedInBuilder(context)
          : nonSignedInBuilder(context);
      },
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
}