import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepo {
  late FirebaseAuth _firebaseAuth;
  late GoogleSignIn _googleSignIn;

  UserRepo({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  //Sign in with google
  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser!;
  }

  //Sign in with credentials
  Future<UserCredential> signInWithCredentials(
      {String? emailAddress, String? password}) async {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: emailAddress!.trim(), password: password!.trim());
  }

  //sign up method
  Future<UserCredential> signUp(
      {String? emailAddress, String? password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddress!.trim(), password: password!.trim());
  }

  //sign out method
  Future<List<void>> signOut() async {
    return Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
  }

  //check if sign in
  Future<bool> isSignedIn() async {
    var _isSignedIn = false;
    _firebaseAuth.authStateChanges().listen((user) {
      user == null ? _isSignedIn = false : _isSignedIn = true;
    });

    return _isSignedIn;
  }

  //get user details
  Future<User?> getUser() async {
    return _firebaseAuth.currentUser;
  }
}
