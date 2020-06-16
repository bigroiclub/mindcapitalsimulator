import 'package:mindcapitalsimulator/src/model/chart_spot.dart';

abstract class TrackDao {
  Future<List<ChartSpot>> fetchTrackRecords(DateTime date);
}