import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mindcapitalsimulator/src/bloc/state/chart_state.dart';
import 'package:mindcapitalsimulator/src/dao/factory_dao.dart';
import 'package:mindcapitalsimulator/src/model/chart_spot.dart';
import 'package:mindcapitalsimulator/src/model/pie_indicator.dart';
import 'package:mindcapitalsimulator/src/model/pie_section_data.dart';

import 'event/chart_event.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  List<ChartSpot> _chartSpots = [];
  double _dayAverage = 0.0;
  double _weekAverage = 0.0;
  double _monthAverage = 0.0;
  final FactoryDao factoryDao;

  List<PieSectionData> _pieSectionDataList = [];
  List<PieIndicator> _pieIndicatorList = [];

  ChartBloc(this.factoryDao);

  @override
  ChartState get initialState => ChartInitState();

  @override
  Stream<ChartState> mapEventToState(ChartEvent event) async* {
    List<ChartSpot> chartSpotsR = [];
    if (event is FetchChartEvent) {
      try {
        this._chartSpots.clear();
        // if(this._chartSpots.length == 0){
        chartSpotsR = await _getChart();
        chartSpotsR.reversed.map((chartSpotR) {
          _chartSpots.add(chartSpotR);
        }).toList();
        // }
        _monthAverage = _calculateMonthAverage(this._chartSpots);
        _weekAverage = _calculateWeekAverage(this._monthAverage);
        _dayAverage = _calculateDayAverage(this._monthAverage);
        yield ChartValuesState(
          chartSpots: this._chartSpots,
          dayAverage: this._dayAverage,
          weekAverage: this._weekAverage,
          monthAverage: this._monthAverage,
        );
      } catch (error) {
        yield error is ChartStateError
            ? ChartStateError(error.message)
            : ChartStateError('Algo fue mal al cargar los datos!');
      }
    } else if (event is SimulatorResultChangeEvent) {
      bool _showReferals = false;
      bool overflow = event.overflow;
      _pieSectionDataList = [];
      _pieIndicatorList = [];

      var _beneficiosNetos = event.beneficiosNetos;
      if (event.beneficiosNetos >= event.beneficiosNetosReferidos && !overflow) {
        _beneficiosNetos =
            (event.beneficiosNetos - event.beneficiosNetosReferidos);
        _showReferals = true;
      }

      // var _aportacionFutura =
      //     (event.aportacionFutura - event.aportacionInicial);
      var _aportacionFutura = event.aportacionFutura;

      _pieSectionDataList.add(
        PieSectionData(
          title: '${event.aportacionInicial.toStringAsFixed(2)}',
          value: event.aportacionInicial, //aportacionFuturax100,
          color: Colors.red,
        ),
      );
      _pieIndicatorList.add(PieIndicator(
        title: event.aportacionInicialText,
        color: Colors.red,
      ));
      //Interés compuesto
      if (event.interesCompuestoFlag && _aportacionFutura != 0.0) {
        _pieSectionDataList.add(
          PieSectionData(
            title: '${_aportacionFutura.toStringAsFixed(2)}',
            value: _aportacionFutura, //aportacionFuturax100,
            color: Colors.green,
          ),
        );
        _pieIndicatorList.add(PieIndicator(
          title: event.intCompuestoText,
          color: Colors.green,
        ));
      }
      //Beneficios Netos
      _pieSectionDataList.add(
        PieSectionData(
          title: '${_beneficiosNetos.toStringAsFixed(2)}',
          value: _beneficiosNetos, //beneficiosNetosx100,
          color: Colors.blue,
        ),
      );
      _pieIndicatorList.add(PieIndicator(
        title: event.beneficiosNetosText,
        color: Colors.blue,
      ));
      //Referidos
      if (event.beneficiosNetosReferidos != 0) {
        if (!event.interesCompuestoFlag) {
          if (_beneficiosNetos == 0.0 || _showReferals) {
            _pieSectionDataList.add(
              PieSectionData(
                title: '${event.beneficiosNetosReferidos.toStringAsFixed(2)}',
                value: event
                    .beneficiosNetosReferidos, //beneficiosNetosReferidosx100,
                color: Colors.yellow,
              ),
            );
            _pieIndicatorList.add(PieIndicator(
              title: event.referidosText,
              color: Colors.yellow,
            ));
          }
        }
      }

      yield SimulatorResultChangeState(
          pieSectionDataList: _pieSectionDataList,
          pieIndicatorList: _pieIndicatorList);
    }
  }

  Future<List<ChartSpot>> _getChart() {
    return this.factoryDao.trackDao.fetchTrackRecords(DateTime.now());
  }

  double _calculateMonthAverage(List<ChartSpot> chartSpots) {
    double monthAverage = 0.0;
    int total = 0;

    chartSpots.map((ChartSpot chartSpot) {
      if (chartSpot.value != 0) {
        monthAverage = monthAverage + chartSpot.value;
        total++;
      }
    }).toList();

    monthAverage != 0
        ? monthAverage = monthAverage / total
        : monthAverage = monthAverage;

    return monthAverage;
  }

  double _calculateWeekAverage(double monthAverage) {
    return monthAverage / 4;
  }

  double _calculateDayAverage(double monthAverage) {
    return monthAverage / 20;
  }
}
