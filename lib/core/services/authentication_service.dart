import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Stream<User> get authStateChanges => firebaseAuth.authStateChanges();

  // Future<AuthResult> signInWithCredential(AuthCredential credential) => firebaseAuth.signInWithCredential(credential);
  // Future<void> logout() => firebaseAuth.signOut();

  User get user => firebaseAuth.currentUser;

  //Google sign in
  Future<User> googleSignIn() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final GoogleAuthCredential credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credentials);
      return userCredential.user != null ? userCredential.user : null;
    } on FirebaseAuthException catch (e) {
      print('error: ${e.message}');
      return null;
    }
  }

  // //Facebook sign in
  Future<User> facebookSignIn() async {
    print('starting facebook login');

    var facebookLogin = FacebookLogin();
    facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    // Logout user before login
    // await facebookLogin.logOut();
    var result = await facebookLogin.logInWithReadPermissions(['email', 'public_profile']);

    switch (result.status) {
      case FacebookLoginStatus.error:
        print("Error: ${result.errorMessage}");
        // onLoginStatusChanged(false);
        return null;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        // onLoginStatusChanged(false);
        return null;
      case FacebookLoginStatus.loggedIn:
        print('token: ${result.accessToken.token}');
        FacebookAuthCredential credential =
            await FacebookAuthProvider.credential(result.accessToken.token);

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
      
        print('user: ${userCredential.user.displayName} is logged in');
        return userCredential.user;
      default:
        return null;
    }
  }

  Future<User> registerUserWithEmailAndPassword(
      {String displayName, String email, String password}) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user.updateProfile(displayName: displayName);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Firebase exception: ${e.message}';
      throw e;
    }
  }

  Future<User> loginWithEmailAndPassword(
      {String email, String password}) async {
    UserCredential userCredential =
        await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  Future<void> logout() async {
    return await firebaseAuth.signOut();
  }
}
