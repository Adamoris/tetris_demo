import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;

  Future login(loginUsername, loginPassword) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginUsername, password: loginPassword);
      return null;
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        // print('username unfound');
      } else if (error.code == 'wrong-password') {
        // print('wrong password');
      }
      return error.message;
    }
  }

  Future register(creationEmail, creationPassword, username) async {
    try {
      final accountCreateAttempt = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: creationEmail, password: creationPassword);
      User? user = accountCreateAttempt.user;
      user?.updateDisplayName(username);
      return null;
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        // print('password is too weak');
      } else if (error.code == 'email-already-in-use') {
        // print('email is already in use');
      } else if (error.code == 'invalid-email') {
        // print('this email address does not exist');
      }
      return error.message;
    }
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
    return null;
  }

  Future verifyEmail() async {
    if (user != null && !user!.emailVerified) {
      // print("User was sent an email!");
      await user?.sendEmailVerification();
      return null;
    } else if (user == null) {
      // print("Hmm, user does not seem to exist");
      return null;
    } else {
      // print(user?.emailVerified);
      return user;
    }
  }
}
