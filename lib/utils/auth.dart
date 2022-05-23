import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
      // await user!.updateDisplayName(name);
      // await user!.reload();
      user = _auth.currentUser;
      await _setUserData(user!.uid, name, user.email, phoneNumber);
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

  static Future<void> _setUserData(id, name, email, phoneNumber) async {
    FirebaseDatabase db = FirebaseDatabase.instance;
    DatabaseReference ref = db.ref("user");
    await ref.child(id).set({
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': "pembeli"
    });
  }

  static Future<UserData> getUserData(id) async {
    FirebaseDatabase db = FirebaseDatabase.instance;
    DatabaseReference ref = db.ref("user/$id");
    String name = "";
    String email = '';
    String phoneNumber = "";
    String role = "";
    String resImg = "";

    try {
      final res = await ref.get();
      for (var item in res.children) {
        if (item.key == "name") {
          name = item.value.toString();
        }
        if (item.key == "email") {
          email = item.value.toString();
        }
        if (item.key == "phoneNumber") {
          phoneNumber = item.value.toString();
        }
        if (item.key == "role") {
          role = item.value.toString();
        }
      }

      try {
        FirebaseStorage _storage = FirebaseStorage.instance;
        final fileName = "$id.jpg";
        final refImg = _storage.ref("user/$fileName");
        resImg = await refImg.getDownloadURL();
      } on FirebaseException catch (e) {
        resImg = '';
        // print(e.message! + "INIIIIIIIIIIIIIIIIIIIIIIIIIII");
      }
    } catch (e) {
      print("User detail data error : $e");
    }
    return UserData(name, email, role, phoneNumber, resImg);
  }

  static Future<void> updateUserData(id, data) async {
    FirebaseDatabase db = FirebaseDatabase.instance;
    DatabaseReference ref = db.ref("user/$id");
    ref.update(data);
  }

  static Future<void> addUserImg(id, path) async {
    FirebaseStorage _storage = FirebaseStorage.instance;
    final fileName = "$id.jpg";
    final ref = _storage.ref("user/$fileName");
    await ref.putFile(File(path)).then((p0) => print("Done"));
  }
}

class UserData {
  String name, email, role, phoneNumber, img;

  UserData(this.name, this.email, this.role, this.phoneNumber, this.img);
}
