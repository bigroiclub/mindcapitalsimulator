import 'package:cloud_firestore/cloud_firestore.dart';

import 'repository.dart';

class FirestoreRepositoryImpl implements Repository {
  @override
  Future fetchTrackRecords(DateTime date) {
    return Firestore.instance.collection('tracks').orderBy('sortByDate', descending: true).limit(7).getDocuments();
  }
}