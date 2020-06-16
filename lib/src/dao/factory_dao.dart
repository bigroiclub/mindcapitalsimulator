import 'interface/track_dao.dart';

class FactoryDao {

  static const String FIREBASE = 'Firebase';
  static const String FIRESTORE = 'Firestore';
  static const String MOCK = 'Mock';

  final TrackDao trackDao;

  FactoryDao({this.trackDao});
}