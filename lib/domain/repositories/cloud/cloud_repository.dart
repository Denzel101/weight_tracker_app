import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';
import 'package:weight_tracker_app/data/models/user/weight_model.dart';

class CloudRepository {
  CloudRepository({
    required FirebaseFirestore firestore,
    required auth.FirebaseAuth firebaseAuth,
  })  : _firebaseAuth = firebaseAuth,
        _firestore = firestore;

  //init
  final auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  static const String weightPath = 'weights';

  Stream<auth.User?> get userStream => _firebaseAuth.authStateChanges();

  //map weight and date to firestore
  Future<WeightModel?> registerWeightAndDate(
      {required String weight, required DateTime dateTime}) async {
    try {
      final uid = _firebaseAuth.currentUser!.uid;
      final id = _firestore.collection(weightPath).doc().id;

      final weightModel =
          WeightModel(userWeight: weight, id: id, uid: uid, dateTime: dateTime);

      await _firestore.collection(weightPath).doc(id).set(weightModel.toMap());
    } on auth.FirebaseAuthException catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    return null;
  }

  //retrieve data from firestore
  Stream<List<WeightModel>> getWeightList() {
    final uid = _firebaseAuth.currentUser?.uid;
    final data = _firestore
        .collection(weightPath)
        .where('uid', isEqualTo: uid)
        .orderBy('dateTime', descending: true)
        .snapshots();

    return data.map((query) {
      return query.docs.map((e) {
        return WeightModel.fromMap(e.data());
      }).toList();
    });
  }

  //delete data from firestore
  Future<void> deleteWeightEntry(String id) async {
    await _firestore.collection(weightPath).doc(id).delete();
  }

  //update data from firestore
  Future<void> updateWeightEntry(String id, String newWeight) async {
    await _firestore
        .collection(weightPath)
        .doc(id)
        .update({'userWeight': newWeight});
  }
}
