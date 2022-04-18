import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    User? user;
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;

      // await user!.updatePhoneNumber(phoneNumber);
      await user!.updateDisplayName(name);
      await user.reload();
      user = _auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
    }
    return user;
  }

  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    User? user;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        throw 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
        throw 'Wrong password provided.';
      }
      // throw e.code;
    }

    return user;
  }

  static Future<User?> refreshUser(User user) async {
    await user.reload();
    User? refreshedUser = _auth.currentUser;

    return refreshedUser;
  }

  static Future<void> logOut() async {
    await _auth.signOut();
  }
}
