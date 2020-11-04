import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindcapitalsimulator/src/bloc/chart_bloc.dart';
import 'package:mindcapitalsimulator/src/bloc/event/chart_event.dart';
import 'package:mindcapitalsimulator/src/bloc/state/chart_state.dart';
import 'package:mindcapitalsimulator/src/locale/locales.dart';
import 'package:mindcapitalsimulator/src/model/chart_spot.dart';
import 'package:toast/toast.dart';

class TrackRecordDesktopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _dayAverage;
    double _weekAverage;
    double _monthAverage;
    List<ChartSpot> _chartSpots = [];

    BlocProvider.of<ChartBloc>(context).add(FetchChartEvent());

    return BlocBuilder<ChartBloc, ChartState>(
        builder: (BuildContext context, state) {
      if (state is ChartValuesState) {
        _dayAverage = state.dayAverage;
        _weekAverage = state.weekAverage;
        _monthAverage = state.monthAverage;
        _chartSpots = state.chartSpots;
      } else if (state is ChartStateError) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Toast.show(state.message, context, gravity: Toast.CENTER, duration: 5);
        });
      }

      return _chartSpots.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Row(
              children: <Widget>[
                Expanded(flex:2, child: _chartWidget(context, _chartSpots),),
                Expanded(flex:1, child: _chartCalculations(context, _dayAverage, _weekAverage, _monthAverage),),
              ],
            );
    });
  }

  _chartWidget(BuildContext context, List<ChartSpot> chartSpots) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20.0),
      child: LineChart(mainData(context, chartSpots),
          swapAnimationDuration: Duration(milliseconds: 250)),
    );
  }

  LineChartData mainData(BuildContext context, List<ChartSpot> chartSpots) {
    List<Color> gradientColors = [
      const Color(0xff23b6e6),
      const Color(0xff02d39a),
    ];

    return LineChartData(
      gridData: FlGridData(
        show: true,
        // drawVerticalLine: true,
        // getDrawingHorizontalLine: (value) {
        //   return const FlLine(
        //     color: Color(0xff37434d),
        //     strokeWidth: 1,
        //   );
        // },
        // getDrawingVerticalLine: (value) {
        //   return const FlLine(
        //     color: Color(0xff37434d),
        //     strokeWidth: 1,
        //   );
        // },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
              color: const Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 12),
          getTitles: (value) {
            return _buildXChart(context, value.toInt(), chartSpots);
          },
          margin: 12,
          // reservedSize: 28,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: const Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 10:
                return '10%';
              case 15:
                return '15%';
              case 20:
                return '20%';
              case 25:
                return '25%';
              case 30:
                return '30%';
            }
            return '';
          },
          // reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 12,
      minY: 10,
      maxY: 30,
      lineBarsData: [
        LineChartBarData(
          spots: _buildChartSpots(chartSpots),
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          // dotData: const FlDotData(
          //   show: false,
          // ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  List<FlSpot> _buildChartSpots(List<ChartSpot> chartSpots) {
    List<FlSpot> flspots = [];
    double index = 0.0;

    chartSpots.map((ChartSpot chartSpot) {
      if (chartSpot.value != 0) flspots.add(FlSpot(index, chartSpot.value));
      index = index + 2;
    }).toList();

    return flspots;
  }

  _chartCalculations(
      BuildContext context, double dayAverage, double weekAverage, double monthAverage) {
    return Container(
      // alignment: Alignment.centerLeft,
      // decoration: BoxDecoration(border: Border.all()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           Container(
            alignment: Alignment.centerLeft,
            child:           Text(
              '${AppLocalizations.of(context).dayAverage}: ${dayAverage.toStringAsFixed(2)}%',
                style: TextStyle(fontSize: 30),),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child:           Text(
              '${AppLocalizations.of(context).weekAverage}: ${weekAverage.toStringAsFixed(2)}%',
                style: TextStyle(fontSize: 30),),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
                '${AppLocalizations.of(context).monthAverage}: ${monthAverage.toStringAsFixed(2)}%',
                style: TextStyle(fontSize: 30),),
          ),
        ],
      ),
    );
  }

  String _buildXChart(
      BuildContext context, int value, List<ChartSpot> chartSpots) {
    var chartSpotsIndex = chartSpots.asMap();
    switch (value) {
      case 0:
        return _month2String(context, chartSpotsIndex[0].month);
      case 2:
        return _month2String(context, chartSpotsIndex[1].month);
      case 4:
        return _month2String(context, chartSpotsIndex[2].month);
      case 6:
        return _month2String(context, chartSpotsIndex[3].month);
      case 8:
        return _month2String(context, chartSpotsIndex[4].month);
      case 10:
        return _month2String(context, chartSpotsIndex[5].month);
      case 12:
        return _month2String(context, chartSpotsIndex[6].month);
    }
    return '';
  }

  String _month2String(BuildContext context, int intMonth) {
    switch (intMonth) {
      case 1:
        return AppLocalizations.of(context).januaryShort;
      case 2:
        return AppLocalizations.of(context).februaryShort;
      case 3:
        return AppLocalizations.of(context).marchShort;
      case 4:
        return AppLocalizations.of(context).aprilShort;
      case 5:
        return AppLocalizations.of(context).mayShort;
      case 6:
        return AppLocalizations.of(context).juneShort;
      case 7:
        return AppLocalizations.of(context).julyShort;
      case 8:
        return AppLocalizations.of(context).augustShort;
      case 9:
        return AppLocalizations.of(context).septemberShort;
      case 10:
        return AppLocalizations.of(context).octoberShort;
      case 11:
        return AppLocalizations.of(context).novemberShort;
      case 12:
        return AppLocalizations.of(context).decemberShort;
    }

    return '';
  }
}
