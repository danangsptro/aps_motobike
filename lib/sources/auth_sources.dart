import 'dart:math';

import 'package:aps_motobike/models/account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_session/d_session.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthSources {
  static Future<String> signup(
      String name, String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Account account =
          Account(uid: credential.user!.uid, name: name, email: email);
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(account.uid)
          .set(account.toJson());

      return 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return ('The account already exists for that email.');
      }
      log(e.toString() as num);
      return 'something worng';
    } catch (e) {
      log(e.toString() as num);
      return 'something worng';
    }
  }

  static Future<String> signIn(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final accountDoc = await FirebaseFirestore.instance
          .collection('User')
          .doc(credential.user!.uid)
          .get();
      await DSession.setUser(Map.from(accountDoc.data()!));
      return 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return ('Wrong password provided for that user.');
      }
      log(e.toString() as num);
      return 'something worng';
    } catch (e) {
      log(e.toString() as num);
      return 'something worng';
    }
  }
}
