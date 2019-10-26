library flamingo;

import 'package:cloud_firestore/cloud_firestore.dart' show DocumentReference, Firestore;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' show FirebaseStorage;

export 'package:flamingo/batch.dart';
export 'package:flamingo/distributed_counter.dart';
export 'package:flamingo/document.dart';
export 'package:flamingo/document_accessor.dart';
export 'package:flamingo/storage.dart';
//export 'package:flamingo/transaction.dart';
export 'package:flamingo/helper/helper.dart';
export 'package:flamingo/master/master.dart';
export 'package:flamingo/model/collection.dart';
export 'package:flamingo/model/counter.dart';
export 'package:flamingo/model/storage_file.dart';
export 'package:flamingo/batch.dart';

class Flamingo {
  static Flamingo instance = Flamingo();
  static void configure({String rootName, int version, FirebaseApp app}) {
    if (app != null) {
      instance.firestore = Firestore(app: app);
      instance.firebaseStorage = FirebaseStorage(app: app);
    } else {
      instance.firestore = Firestore.instance;
      instance.firebaseStorage = FirebaseStorage.instance;
    }
    instance.rootReference =
        instance.firestore.collection('${rootName != null ? rootName : 'version'}')
            .document('${version != null ? version.toString() : '1'}');
  }
  DocumentReference rootReference;
  Firestore firestore;
  FirebaseStorage firebaseStorage;
}

Firestore firestoreInstance() {
  return Flamingo.instance.firestore;
}

FirebaseStorage storageInstance() {
  return Flamingo.instance.firebaseStorage;
}