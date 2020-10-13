import 'interface/login_dao.dart';
import 'interface/track_dao.dart';

class FactoryDao {

  static const String FIREBASE = 'Firebase';
  static const String FIRESTORE = 'Firestore';
  static const String MOCK = 'Mock';

  final TrackDao trackDao;
  final LoginDao loginDao;

  FactoryDao({this.trackDao, this.loginDao});
}