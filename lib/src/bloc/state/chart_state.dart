import 'package:mindcapitalsimulator/src/model/chart_spot.dart';
import 'package:mindcapitalsimulator/src/model/pie_indicator.dart';
import 'package:mindcapitalsimulator/src/model/pie_section_data.dart';

abstract class ChartState {}

class ChartInitState extends ChartState {
  @override
  String toString() => 'ChartStateEmpty';
}

class ChartValuesState extends ChartState {
  double dayAverage;
  double weekAverage;
  double monthAverage;
  List<ChartSpot> chartSpots;

  ChartValuesState(
      {this.dayAverage, this.weekAverage, this.monthAverage, this.chartSpots,});

  @override
  String toString() => 'Chart Values State';
}

class SimulatorResultChangeState extends ChartState {
  final List<PieSectionData> pieSectionDataList;
  final List<PieIndicator> pieIndicatorList;

  SimulatorResultChangeState({this.pieSectionDataList, this.pieIndicatorList});

  @override
  String toString() => 'Chart Values State';
}

class ChartStateError extends ChartState {
  final String message;

  ChartStateError(this.message);

  @override
  String toString() => 'RankingStateError';
}