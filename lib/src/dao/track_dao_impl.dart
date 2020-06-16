import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindcapitalsimulator/src/model/chart_spot.dart';
import 'package:mindcapitalsimulator/src/repository/firestore_repository_impl.dart';

import 'interface/track_dao.dart';

class TrackDaoImpl implements TrackDao {
  final FirestoreRepositoryImpl _firestore = FirestoreRepositoryImpl();
  
  @override
  Future<List<ChartSpot>> fetchTrackRecords(DateTime date) async{
    QuerySnapshot querySnapshot = await _firestore.fetchTrackRecords(date);

    // RankingItemDetail rankingItemDetail = RankingItemDetail(
    //   id: snapshot.documentID,
    //   title: snapshot.data['title'],
    //   description: snapshot.data['description'],
    //   roiRating: double.parse(snapshot.data['roiRating'].toString()),
    //   riskRating: double.parse(snapshot.data['riskRating'].toString()),
    //   image: snapshot.data['image'],
    // );

    // return Future.value(rankingItemDetail);

    List<ChartSpot> chartSpots = [];

    querySnapshot.documents.map((snapshot){
      chartSpots.add(
      ChartSpot(year: snapshot.data['year'],
                month: snapshot.data['month'],
                value: double.parse(snapshot.data['value'] ) ) );
    }).toList();

    return Future.value(chartSpots);
    
  }
}