// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:predict_coffee/data/models/single_predict_models/single_predict_models.dart';

import '../models/user_models/user_model.dart';

abstract class FirebaseDataSource {
  Future<UserModel> register(UserModel user);
  Future<UserModel> login(UserModel user);
  Future<UserModel> getCurrentUser(String id);
  Future<void> logout();
  Future<void> createHistory(List<PredictionModel> predictions);
}

class FirebaseDataSourceIMPL extends FirebaseDataSource {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseDataSourceIMPL({required this.auth, required this.firestore});

  @override
  Future<UserModel> register(UserModel user) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password as String,
      );

      String uid = userCredential.user!.uid;

      await firestore.collection('users').doc(uid).set(user.toMap());

      DocumentSnapshot snapshot = await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      return UserModel(
        username: snapshot['username'],
        email: snapshot['email'],
      );
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<UserModel> login(UserModel user) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password as String,
      );

      DocumentSnapshot snapshot = await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      return UserModel(
        username: snapshot['username'],
        email: snapshot['email'],
      );
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<UserModel> getCurrentUser(String id) async {
    try {
      DocumentSnapshot snapshot =
          await firestore.collection('users').doc(id).get();

      return UserModel(
        username: snapshot['username'],
        email: snapshot['email'],
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> createHistory(predictions) async {
    try {
      User user = auth.currentUser as User;
      DateTime dateNow = DateTime.now();
      String todayDocId = DateFormat.yMd().format(dateNow).replaceAll('/', '-');

      CollectionReference historyReference =
          firestore.collection('users').doc(user.uid).collection('history');

      var predictionsMap =
          predictions.map((prediction) => prediction.toJson()).toList();

      await historyReference.doc(todayDocId).set({
        'predictions': predictionsMap,
        'timestamp': DateTime.now(),
      });
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
