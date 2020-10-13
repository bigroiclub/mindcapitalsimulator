import 'package:mindcapitalsimulator/src/repository/firestore_repository_impl.dart';

import 'interface/login_dao.dart';

class LoginDaoImpl implements LoginDao {
  final FirestoreRepositoryImpl _firestore = FirestoreRepositoryImpl();
  
  @override
  Future signIn(String email) async{
    return await _firestore.signIn(email);
  }
}