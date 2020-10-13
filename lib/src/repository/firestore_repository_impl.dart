import 'package:cloud_firestore/cloud_firestore.dart';

import 'interface/repository.dart';

class FirestoreRepositoryImpl implements Repository {
  @override
  Future fetchTrackRecords(DateTime date) {
    return Firestore.instance.collection('mindcapitalsimulator').document('live').collection('tracks').orderBy('sortByDate', descending: true).limit(7).getDocuments();
  }

  Future signIn(String email) async {
    QuerySnapshot query = await Firestore.instance.collection('users').where('email', isEqualTo: email).getDocuments();
    // QuerySnapshot query = await Firestore.instance.collection('users').getDocuments();
    if(query.documents.isNotEmpty)
      return Future.value(query.documents.first.data['email']);

    return null;
  }
}