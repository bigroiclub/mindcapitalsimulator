abstract class Repository {
   Future<dynamic> fetchTrackRecords(DateTime date);
   Future signIn(String email);
}