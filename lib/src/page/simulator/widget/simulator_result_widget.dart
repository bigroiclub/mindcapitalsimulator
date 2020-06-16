import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/flutter_counter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mindcapitalsimulator/src/bloc/calculation_bloc.dart';
import 'package:mindcapitalsimulator/src/bloc/chart_bloc.dart';
import 'package:mindcapitalsimulator/src/bloc/event/calculation_event.dart';
import 'package:mindcapitalsimulator/src/bloc/event/chart_event.dart';
import 'package:mindcapitalsimulator/src/bloc/event/home_event.dart';
import 'package:mindcapitalsimulator/src/bloc/home_bloc.dart';
import 'package:mindcapitalsimulator/src/bloc/state/calculation_state.dart';
import 'package:mindcapitalsimulator/src/bloc/state/chart_state.dart';
import 'package:mindcapitalsimulator/src/locale/locales.dart';
import 'package:mindcapitalsimulator/src/model/pie_indicator.dart';
import 'package:mindcapitalsimulator/src/model/pie_section_data.dart';
import 'package:mindcapitalsimulator/src/widget/Info_icon_button.dart';
import 'package:mindcapitalsimulator/src/widget/custom_button.dart';
import 'package:mindcapitalsimulator/src/widget/custom_snackbar.dart';

class SimulatorResultWidget extends StatelessWidget {
  final bool withCalcButton;

  SimulatorResultWidget({Key key, this.withCalcButton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _aportacionFutura = 0.0;
    double _beneficiosNetos = 0.0;
    bool _interesCompuestoFlag = false;
    double _beneficiosNetosReferidos;
    TipoGanancias _tipoGanancia;
    int _mesesCounter;
    bool _infoIntCompuesto;
    List<PieSectionData> pieSectionDataList;
    List<PieIndicator> pieIndicatorList;
    bool _isLoading = false;
    double _beneficiosPlataforma;
    double _beneficiosTotales;
    bool _infoProfitButton;

    return BlocBuilder<CalculationBloc, CalculationState>(
      builder: (BuildContext context, state) {
        if (state is CalculationInitState) {
          _aportacionFutura = state.aportacionFutura;
          _beneficiosNetos = state.beneficiosNetos;
          _interesCompuestoFlag = state.interesCompuestoFlag;
          _tipoGanancia = state.tipoGanancia;
          _mesesCounter = state.mesesCounter;
          _beneficiosNetosReferidos = state.beneficiosNetosReferidos;
          _infoIntCompuesto = state.infoIntCompuesto;
          _beneficiosPlataforma = state.beneficiosPlataforma;
          _beneficiosTotales = state.beneficiosTotales;
          _infoProfitButton = state.infoProfitButton;
          _isLoading = true;
          BlocProvider.of<ChartBloc>(context).add(SimulatorResultChangeEvent(
              aportacionInicialText:
                  AppLocalizations.of(context).initContribution,
              aportacionInicial: state.aportacion,
              beneficiosNetosText:
                  AppLocalizations.of(context).benefitsAvailable,
              beneficiosNetos: _beneficiosNetos,
              intCompuestoText: AppLocalizations.of(context).compContribution,
              aportacionFutura: _aportacionFutura,
              interesCompuestoFlag: _interesCompuestoFlag,
              beneficiosTotalesText: AppLocalizations.of(context).total,
              beneficiosTotales: state.beneficiosTotales,
              beneficiosPlataformaText: AppLocalizations.of(context).platform,
              beneficiosPlataforma: state.beneficiosPlataforma,
              referidosText: AppLocalizations.of(context).referProfit,
              beneficiosNetosReferidos: _beneficiosNetosReferidos));
        } else if (state is ReSimulationState) {
          _aportacionFutura = state.aportacionFutura;
          _beneficiosNetos = state.beneficiosNetos;
          _interesCompuestoFlag = state.interesCompuestoFlag;
          _beneficiosNetosReferidos = state.beneficiosNetosReferidos;
          _tipoGanancia = state.tipoGanancias;
          _mesesCounter = state.mesesCounter;
          _infoIntCompuesto = state.infoIntCompuesto;
          _beneficiosPlataforma = state.beneficiosPlataforma;
          _beneficiosTotales = state.beneficiosTotales;
          _infoProfitButton = state.infoProfitButton;
          _isLoading = true;
          BlocProvider.of<ChartBloc>(context).add(SimulatorResultChangeEvent(
              aportacionInicialText:
                  AppLocalizations.of(context).initContribution,
              aportacionInicial: state.aportacion,
              beneficiosNetosText:
                  AppLocalizations.of(context).benefitsAvailable,
              beneficiosNetos: _beneficiosNetos,
              intCompuestoText: AppLocalizations.of(context).compContribution,
              aportacionFutura: _aportacionFutura,
              interesCompuestoFlag: _interesCompuestoFlag,
              beneficiosTotalesText: AppLocalizations.of(context).total,
              beneficiosTotales: state.beneficiosTotales,
              beneficiosPlataformaText: AppLocalizations.of(context).platform,
              beneficiosPlataforma: state.beneficiosPlataforma,
              referidosText: AppLocalizations.of(context).referProfit,
              beneficiosNetosReferidos: _beneficiosNetosReferidos));
        } else if (state is CalculationStateError) {
          CustomSnackBar().show(context: context, message: state.message);
        }
        return BlocBuilder<ChartBloc, ChartState>(
            builder: (BuildContext context, state) {
          if (state is ChartInitState) {
            // BlocProvider.of<ChartBloc>(context).add(SimulatorResultChangeEvent(
            //     aportacionInicialText: AppLocalizations.of(context).initContribution,
            //     aportacionInicial: state.aportacion,
            //     beneficiosNetosText:
            //         AppLocalizations.of(context).benefitsAvailable,
            //     beneficiosNetos: _beneficiosNetos,
            //     intCompuestoText: AppLocalizations.of(context).compContribution,
            //     aportacionFutura: _aportacionFutura,
            //     interesCompuestoFlag: _interesCompuestoFlag,
            //     referidosText: AppLocalizations.of(context).referProfit,
            // beneficiosNetosReferidos: _beneficiosNetosReferidos));
            _isLoading = true;
          } else if (state is SimulatorResultChangeState) {
            pieSectionDataList = state.pieSectionDataList;
            pieIndicatorList = state.pieIndicatorList;
            _isLoading = false;
          }

          if (_isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );

          return ListView(
            children: <Widget>[
              _backButton(context, withCalcButton),
              _beneficiosWidget(
                  context,
                  _beneficiosNetos,
                  _beneficiosPlataforma,
                  _beneficiosNetosReferidos,
                  _beneficiosTotales,
                  _infoProfitButton,
                  withCalcButton),
              _interesCompuestoWidget(
                  context, _infoIntCompuesto, _interesCompuestoFlag),
              _monthSliderWidget(context, _tipoGanancia, _mesesCounter),
              _pieChart(context, pieSectionDataList, pieIndicatorList,
                  withCalcButton),
            ],
          );
        });
      },
    );
  }

  _monthSliderWidget(
      BuildContext context, TipoGanancias _tipoGanancia, int _mesesCounter) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Visibility(
        visible: _tipoGanancia == TipoGanancias.mensual,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text('${AppLocalizations.of(context).months}:'),
            Counter(
              initialValue: _mesesCounter,
              minValue: 1,
              maxValue: 60,
              step: 1,
              decimalPlaces: 0,
              onChanged: (value) {
                BlocProvider.of<CalculationBloc>(context)
                    .add(CambioMesesCounterEvent(value));
              },
            ),
            CustomButton(
              child: Text('${AppLocalizations.of(context).reset}'),
              onPressed: () {
                BlocProvider.of<CalculationBloc>(context)
                    .add(CambioMesesCounterEvent(1));
              },
            ),
          ],
        ),
      ),
    );
  }

  _interesCompuestoWidget(BuildContext context, bool _infoIntCompuesto,
      bool _interesCompuestoFlag) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 14,
            child: _interesCompuesto(
              context,
              _infoIntCompuesto,
            ),
          ),
          Expanded(
            flex: 1,
            child: _interesCompuestoFlagWidget(context, _interesCompuestoFlag),
          ),
        ],
      ),
    );
  }

  _interesCompuesto(BuildContext context, bool infoInteresCompuesto) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('${AppLocalizations.of(context).compInterest}'),
        InfoIconButton(
          visibility: infoInteresCompuesto,
          content: Text(
            AppLocalizations.of(context).infoInteresCompuesto,
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () => BlocProvider.of<CalculationBloc>(context)
              .add(CambioInfoIntCompuestoEvent()),
        ),
      ],
    );
  }

  _interesCompuestoFlagWidget(
      BuildContext context, bool _interesCompuestoFlag) {
    return Switch(
      inactiveThumbColor: Colors.blue,
      activeColor: Colors.green,
      value: _interesCompuestoFlag,
      onChanged: (value) {
        BlocProvider.of<CalculationBloc>(context)
            .add(FlagInteresCompuestoEvent());
      },
    );
  }

  _backButton(BuildContext context, bool withCalcButton) {
    return Visibility(
      visible: withCalcButton,
      child: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.only(right: 95),
        child: IconButton(
          //child: Text(AppLocalizations.of(context).back),
          icon: Icon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.blue,
          ),
          onPressed: () =>
              BlocProvider.of<HomeBloc>(context).add(CalculateBackEvent()),
        ),
      ),
    );
  }

  _beneficiosWidget(
      BuildContext context,
      double _beneficiosNetos,
      double _beneficiosPlataforma,
      double _beneficiosNetosReferidos,
      double _beneficiosTotales,
      bool _infoProfitButton,
      bool withCalcButton) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // SizedBox(
        //   height: 5.0,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${AppLocalizations.of(context).benefitsAvailable}:'),
            InfoIconButton(
              visibility: _infoProfitButton,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      Text('${AppLocalizations.of(context).total}:',
                          style: TextStyle(color: Colors.white)),
                      Text('${_beneficiosTotales.toStringAsFixed(2)} \$',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Wrap(
                    children: [
                      Text('${AppLocalizations.of(context).platform} (35%):',
                          style: TextStyle(color: Colors.white)),
                      Text('${_beneficiosPlataforma.toStringAsFixed(2)} \$',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
              onPressed: () => BlocProvider.of<CalculationBloc>(context)
                  .add(CambioInfoProfitEvent()),
            ),
          ],
        ),
        Text(
          '${_beneficiosNetos.toStringAsFixed(2)} \$',
          style: TextStyle(fontSize: 30),
        ),
        Visibility(
            visible: _beneficiosNetosReferidos != 0,
            child: Column(
              children: [
                Text(AppLocalizations.of(context).ofWhich),
                Text(
                    '${AppLocalizations.of(context).referProfit}: ${_beneficiosNetosReferidos.toStringAsFixed(2)} \$'),
              ],
            )),
      ],
    );
  }

  Widget _pieChart(
      BuildContext context,
      List<PieSectionData> pieSectionDataList,
      List<PieIndicator> pieIndicatorList,
      bool withCalcButton) {
    if (withCalcButton)
      return Column(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: pieIndicatorList
                .map<IndicatorWidget>((PieIndicator pieIndicator) {
              return IndicatorWidget(
                color: pieIndicator.color,
                text: pieIndicator.title,
                isSquare: pieIndicator.isSquare,
              );
            }).toList(),
          ),
          PieChart(
            PieChartData(
              pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                //   BlocProvider.of<DashboardBloc>(context).add(
                //       ChangePieEvent(
                //           pieTouchResponse: pieTouchResponse));
              }),
              borderData: FlBorderData(
                show: false,
              ),
              // sectionsSpace: 0,
              centerSpaceRadius: 80,
              startDegreeOffset: 30.0,
              sections: showingSections(pieSectionDataList),
            ),
          ),
        ],
      );
    else
      return Row(
        children: <Widget>[
          Flexible(
            flex: 2,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                  //   BlocProvider.of<DashboardBloc>(context).add(
                  //       ChangePieEvent(
                  //           pieTouchResponse: pieTouchResponse));
                }),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 75,
                startDegreeOffset: 30.0,
                sections: showingSections(pieSectionDataList),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: pieIndicatorList
                  .map<IndicatorWidget>((PieIndicator pieIndicator) {
                return IndicatorWidget(
                  color: pieIndicator.color,
                  text: pieIndicator.title,
                  isSquare: pieIndicator.isSquare,
                );
              }).toList(),
            ),
          ),
        ],
      );
  }

  List<PieChartSectionData> showingSections(
      List<PieSectionData> pieSectionDataList) {
    return pieSectionDataList
        .map<PieChartSectionData>((PieSectionData pieSectionData) {
      final isTouched = pieSectionData.isTouched;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      return PieChartSectionData(
        color: pieSectionData.color,
        value: pieSectionData.value,
        title: pieSectionData.title,
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black),
      );
    }).toList();
  }
}

class IndicatorWidget extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const IndicatorWidget({
    Key key,
    this.color,
    this.text,
    this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        )
      ],
    );
  }
}
