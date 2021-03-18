part of "providers.dart";

class AuthenticationViewModel with ChangeNotifier {
  AuthenticationViewModel({required this.auth});
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool isLoading = false;
  dynamic error;

  Future<void> signUpWithGoogle() async{
    try {
      isLoading = true;
      notifyListeners();
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;
      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
      );
      await auth.signInWithCredential(
        credentials
      );
      error = null;
    } catch (e) {
      error = e;
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOutWithGoogle() async {
    try {
      isLoading = true;
      notifyListeners();
      await googleSignIn.disconnect().whenComplete(() async {
        await auth.signOut();
      });
      error = null;
    } catch (e) {
      error = e;
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }  
    notifyListeners();
  }
}