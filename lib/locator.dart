import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:weight_tracker_app/domain/repositories/cloud/cloud_repository.dart';

import 'domain/repositories/auth/auth_repository.dart';

final GetIt locator = GetIt.instance;

void setUpLocator() {
  // Repository
  locator.registerFactory<AuthRepository>(
    () => AuthRepository(
      firebaseAuth: FirebaseAuth.instance,
    ),
  );

  locator.registerSingleton(
    CloudRepository(
      firestore: FirebaseFirestore.instance,
      firebaseAuth: FirebaseAuth.instance,
    ),
  );
}
