import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mindcapitalsimulator/src/bloc/calculation_bloc.dart';
import 'package:mindcapitalsimulator/src/bloc/event/calculation_event.dart';
import 'package:mindcapitalsimulator/src/bloc/event/home_event.dart';
import 'package:mindcapitalsimulator/src/bloc/home_bloc.dart';
import 'package:mindcapitalsimulator/src/bloc/state/calculation_state.dart';
import 'package:mindcapitalsimulator/src/locale/locales.dart';
import 'package:mindcapitalsimulator/src/widget/Info_icon_button.dart';
import 'package:mindcapitalsimulator/src/widget/custom_button.dart';
import 'package:mindcapitalsimulator/src/widget/custom_snackbar.dart';

class SimulatorCockpitWidget extends StatefulWidget {
  final bool withCalcButton;

  SimulatorCockpitWidget({Key key, this.withCalcButton = false})
      : super(key: key);
  @override
  _SimulatorCockpitWidgetState createState() => _SimulatorCockpitWidgetState();
}

class _SimulatorCockpitWidgetState extends State<SimulatorCockpitWidget> {
  double _aportacionTotalReferido;
  double _porcGanancias;
  double _gananciaMin;
  double _gananciaMax;
  TipoGanancias _tipoGanancia;
  int _mesesCounter;

  bool _infoPlatform;
  double _beneficiosTotales;
  double _beneficiosPlataforma;

  bool _isExpanded = false;
  bool _showRetiro = false;
  bool _showPro = false;
  TextEditingController _aportacionController = TextEditingController();
  TextEditingController _retiroController = TextEditingController();
  TextEditingController _referalLevel1Controller = TextEditingController();
  TextEditingController _referalLevel2Controller = TextEditingController();
  TextEditingController _referalLevel3Controller = TextEditingController();
  TextEditingController _referalLevel4Controller = TextEditingController();
  TextEditingController _referalLevel5Controller = TextEditingController();
  TextEditingController _referalLevel6Controller = TextEditingController();
  TextEditingController _referalLevel7Controller = TextEditingController();
  TextEditingController _referalLevel8Controller = TextEditingController();
  TextEditingController _referalLevel9Controller = TextEditingController();
  TextEditingController _referalLevel10Controller = TextEditingController();
  final _aportacionKey = GlobalKey<FormState>();
  final _withdrawKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculationBloc, CalculationState>(
        builder: (BuildContext context, state) {
      if (state is CalculationInitState) {
        _aportacionController.text = state.aportacion.toStringAsFixed(2);
        // _aportacionFutura = state.aportacionFutura;
        _aportacionTotalReferido = state.aportacionTotalReferido;
        _beneficiosTotales = state.beneficiosTotales;
        _beneficiosPlataforma = state.beneficiosPlataforma;
        // _beneficiosNetos = state.beneficiosNetos;
        _gananciaMin = state.gananciaMin;
        _gananciaMax = state.gananciaMax;
        _porcGanancias = state.porcGanancias;
        _tipoGanancia = state.tipoGanancia;
        _infoPlatform = state.infoPlatform;
        // _interesCompuestoFlag = state.interesCompuestoFlag;
        _mesesCounter = state.mesesCounter;

        // _aportacionController.text = _aportacion.toStringAsFixed(0);
        // _aportacionController.text == ''
        //     ? _aportacionController.text = '0'
        //     : _aportacionController.text = '';

        _retiroController.text == ''
            ? _retiroController.text = '0'
            : _retiroController.text = '';
        // _retiroController.text = state.retiro.toStringAsExponential(0);

        _isExpanded = state.isExpanded;
        _referalLevel1Controller.text = state.referLevel1.toStringAsFixed(0);
        _referalLevel2Controller.text = state.referLevel2.toStringAsFixed(0);
        _referalLevel3Controller.text = state.referLevel3.toStringAsFixed(0);
        _referalLevel4Controller.text = state.referLevel4.toStringAsFixed(0);
        _referalLevel5Controller.text = state.referLevel5.toStringAsFixed(0);
        _referalLevel6Controller.text = state.referLevel6.toStringAsFixed(0);
        _referalLevel7Controller.text = state.referLevel7.toStringAsFixed(0);
        _referalLevel8Controller.text = state.referLevel8.toStringAsFixed(0);
        _referalLevel9Controller.text = state.referLevel9.toStringAsFixed(0);
        _referalLevel10Controller.text = state.referLevel10.toStringAsFixed(0);
      } else if (state is ReSimulationState) {
        if(state.resetData) {
          _aportacionController.clear();
          _retiroController.clear();
          _referalLevel1Controller.clear();
          _referalLevel2Controller.clear();
          _referalLevel3Controller.clear();
          _referalLevel4Controller.clear();
          _referalLevel5Controller.clear();
          _referalLevel6Controller.clear();
          _referalLevel7Controller.clear();
          _referalLevel8Controller.clear();
          _referalLevel9Controller.clear();
          _referalLevel10Controller.clear();
        }

        if (_aportacionController.text.compareTo('') == 0)
          _aportacionController.text = state.aportacion.toStringAsFixed(0);
        _aportacionTotalReferido = state.aportacionTotalReferido;

        if (_retiroController.text.compareTo('') ==
            0) // || state.retiro == 0.0)
          _retiroController.text = state.retiro.toStringAsFixed(0);

        _showRetiro = state.showRetiro;
        _showPro = state.showPro;

        if (_referalLevel1Controller.text.compareTo('') == 0)
          _referalLevel1Controller.text = state.referLevel1.toStringAsFixed(0);
        if (_referalLevel2Controller.text.compareTo('') == 0)
          _referalLevel2Controller.text = state.referLevel2.toStringAsFixed(0);
        if (_referalLevel3Controller.text.compareTo('') == 0)
          _referalLevel3Controller.text = state.referLevel3.toStringAsFixed(0);
        if (_referalLevel4Controller.text.compareTo('') == 0)
          _referalLevel4Controller.text = state.referLevel4.toStringAsFixed(0);
        if (_referalLevel5Controller.text.compareTo('') == 0)
          _referalLevel5Controller.text = state.referLevel5.toStringAsFixed(0);
        if (_referalLevel6Controller.text.compareTo('') == 0)
          _referalLevel6Controller.text = state.referLevel6.toStringAsFixed(0);
        if (_referalLevel7Controller.text.compareTo('') == 0)
          _referalLevel7Controller.text = state.referLevel7.toStringAsFixed(0);
        if (_referalLevel8Controller.text.compareTo('') == 0)
          _referalLevel8Controller.text = state.referLevel8.toStringAsFixed(0);
        if (_referalLevel9Controller.text.compareTo('') == 0)
          _referalLevel9Controller.text = state.referLevel9.toStringAsFixed(0);
        if (_referalLevel10Controller.text.compareTo('') == 0)
          _referalLevel10Controller.text =
              state.referLevel10.toStringAsFixed(0);

        _isExpanded = state.isExpanded;

        // _aportacionFutura = state.aportacionFutura;
        _beneficiosTotales = state.beneficiosTotales;
        _beneficiosPlataforma = state.beneficiosPlataforma;
        // _beneficiosNetos = state.beneficiosNetos;
        _porcGanancias = state.porcGanancias;
        // _interesCompuestoFlag = state.interesCompuestoFlag;
        _mesesCounter = state.mesesCounter;
        _gananciaMin = state.gananciaMin;
        _gananciaMax = state.gananciaMax;
        _tipoGanancia = state.tipoGanancias;
        _infoPlatform = state.infoPlatform;

      } else if (state is CalculationStateError) {
        CustomSnackBar().show(context: context, message: state.message);
      }
      return ListView(
        padding: EdgeInsets.all(9.0),
        children: [
          _aportacionWidget(context, _aportacionController),
          _profitWidget(
              context,
              _porcGanancias,
              _gananciaMin,
              _gananciaMax,
              _tipoGanancia,
              _mesesCounter,
              _infoPlatform,
              _beneficiosTotales,
              _beneficiosPlataforma),
          _showProButton(context, _showPro),
          _withdraw(context, _showPro, _showRetiro, _retiroController),
          _aportacionReferidosWidget(
              context,
              _showPro,
              _aportacionTotalReferido,
              _isExpanded,
              _referalLevel1Controller,
              _referalLevel2Controller,
              _referalLevel3Controller,
              _referalLevel4Controller,
              _referalLevel5Controller,
              _referalLevel6Controller,
              _referalLevel7Controller,
              _referalLevel8Controller,
              _referalLevel9Controller,
              _referalLevel10Controller),
          _calcButton(context, widget.withCalcButton),
        ],
      );
    });
  }

  _aportacionWidget(
      BuildContext context, TextEditingController _aportacionController) {
    return Form(
      key: _aportacionKey,
      child: TextFormField(
        controller: _aportacionController,
        style: TextStyle(fontSize: 20.0),
        decoration: InputDecoration(
            labelText: '${AppLocalizations.of(context).initContribution}'),
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (_aportacionKey.currentState.validate()) {
            BlocProvider.of<CalculationBloc>(context)
                .add(CambioAportacionEvent(aportacion: double.parse(value)));
          } else {
            BlocProvider.of<CalculationBloc>(context)
                .add(ResetBeneficiosEvent());
          }
        },
        onTap: () {
          _aportacionController.text.startsWith('0')
              ? _aportacionController.text = ''
              : _aportacionController.text = _aportacionController.text;
        },
        validator: (value) {
          double aportacion = double.parse(value);
          if (aportacion < 40) {
            BlocProvider.of<CalculationBloc>(context)
                .add(ResetBeneficiosEvent());
            return '${AppLocalizations.of(context).minContribution} 40\$';
          } else if (aportacion > 100000) {
            BlocProvider.of<CalculationBloc>(context)
                .add(ResetBeneficiosEvent());
            return '${AppLocalizations.of(context).maxContribution} 100.000\$';
          }
          return null;
        },
      ),
    );
  }

  _withdraw(BuildContext context, bool showPro, bool showWithdraw,
      TextEditingController withdrawController) {
    return Visibility(
      visible: showWithdraw && showPro,
      child: Form(
        key: _withdrawKey,
        child: TextFormField(
          controller: withdrawController,
          style: TextStyle(fontSize: 20.0),
          decoration: InputDecoration(
              labelText: '${AppLocalizations.of(context).withdraw}'),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            double withdraw = double.parse(value);
            if (!_withdrawKey.currentState.validate()) withdraw = 0.0;

            BlocProvider.of<CalculationBloc>(context)
                .add(CambioRetiroEvent(withdraw));
          },
          onTap: () {
            withdrawController.text.startsWith('0')
                ? withdrawController.text = ''
                : withdrawController.text = withdrawController.text;
          },
          validator: (value) {
            double withdraw = double.parse(value);
            if (withdraw < 50) {
              return '${AppLocalizations.of(context).minWithdraw} 50\$';
            }
            return null;
          },
        ),
      ),
    );
  }

  _showProButton(BuildContext context, bool _showPro) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(AppLocalizations.of(context).proSettings),
        Container(
          alignment: Alignment.centerRight,
          child: Switch(
            inactiveThumbColor: Colors.blue,
            activeColor: Colors.green,
            value: _showPro,
            onChanged: (value) {
              BlocProvider.of<CalculationBloc>(context)
                  .add(FlagProSettingsEvent());
            },
          ),
        ),
        IconButton(
          icon: Icon(FontAwesomeIcons.trash, color: Colors.blue,),
          tooltip: 'Borrar Datos',
          onPressed: () {
            BlocProvider.of<CalculationBloc>(context).add(ResetDataEvent());
          },
        ),
      ],
    );
  }

  _calcButton(BuildContext context, bool withCalcButton) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Visibility(
        visible: withCalcButton,
        child: CustomButton(
          child: Text(AppLocalizations.of(context).simulate),
          onPressed: () =>
              BlocProvider.of<HomeBloc>(context).add(CalculateEvent()),
        ),
      ),
    );
  }

  _aportacionReferidosWidget(
      BuildContext context,
      bool showPro,
      double _aportacionTotalReferido,
      bool _isExpanded,
      TextEditingController _referalLevel1Controller,
      TextEditingController _referalLevel2Controller,
      TextEditingController _referalLevel3Controller,
      TextEditingController _referalLevel4Controller,
      TextEditingController _referalLevel5Controller,
      TextEditingController _referalLevel6Controller,
      TextEditingController _referalLevel7Controller,
      TextEditingController _referalLevel8Controller,
      TextEditingController _referalLevel9Controller,
      TextEditingController _referalLevel10Controller) {
    return Visibility(
      visible: showPro,
      child: ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            BlocProvider.of<CalculationBloc>(context)
                .add(ExpandPanelEvent(!_isExpanded));
          },
          children: [
            ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text(
                      '${AppLocalizations.of(context).referTotal}: ${_aportacionTotalReferido.toStringAsFixed(2)}'),
                );
              },
              body: Card(
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0, bottom: 4.0),
                  child: Column(children: <Widget>[
                    _levelN(context, 1, _referalLevel1Controller,
                        AppLocalizations.of(context).referLevel1, 8, 100),
                    _levelN(context, 2, _referalLevel2Controller,
                        AppLocalizations.of(context).referLevel2, 4, 100),
                    _levelN(context, 3, _referalLevel3Controller,
                        AppLocalizations.of(context).referLevel3, 3, 5000),
                    _levelN(context, 4, _referalLevel4Controller,
                        AppLocalizations.of(context).referLevel4, 3, 5000),
                    _levelN(context, 5, _referalLevel5Controller,
                        AppLocalizations.of(context).referLevel5, 2, 15000),
                    _levelN(context, 6, _referalLevel6Controller,
                        AppLocalizations.of(context).referLevel6, 2, 15000),
                    _levelN(context, 7, _referalLevel7Controller,
                        AppLocalizations.of(context).referLevel7, 2, 50000),
                    _levelN(context, 8, _referalLevel8Controller,
                        AppLocalizations.of(context).referLevel8, 2, 50000),
                    _levelN(context, 9, _referalLevel9Controller,
                        AppLocalizations.of(context).referLevel9, 2, 100000),
                    _levelN(context, 10, _referalLevel10Controller,
                        AppLocalizations.of(context).referLevel10, 2, 100000),
                  ]),
                ),
              ),
              isExpanded: _isExpanded,
            ),
          ]),
    );
  }

  _levelN(
      BuildContext context,
      int index,
      TextEditingController referalController,
      String title,
      int percent,
      int minInput) {
    return TextFormField(
      controller: referalController,
      decoration: InputDecoration(labelText: '$percent% $title $minInput\$'),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        double aportacionReferido;

        if (referalController.text.compareTo('') == 0)
          aportacionReferido = 0.0;
        else
          aportacionReferido = double.parse(referalController.text);
        BlocProvider.of<CalculationBloc>(context).add(
            CambioAportacionReferidoEvent(
                index: index, aportacionReferido: aportacionReferido));
      },
      onTap: () {
        referalController.text.startsWith('0')
            ? referalController.text = ''
            : referalController.text = referalController.text;
      },
      validator: (value) {
        double aportacionReferido = double.parse(value);
        if (aportacionReferido < minInput) {
          return '${AppLocalizations.of(context).minContribution} $minInput\$';
        }
        return null;
      },
    );
  }

  _profitWidget(
      BuildContext context,
      double _porcGanancias,
      double _gananciaMin,
      double _gananciaMax,
      TipoGanancias _tipoGanancia,
      int _mesesCounter,
      bool _infoPlatform,
      double _beneficiosTotales,
      double _beneficiosPlataforma) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                  '${AppLocalizations.of(context).profit}: ${_porcGanancias.toStringAsFixed(2)} %'),
            ),
            _infoPlatformWidget(context, _infoPlatform),
          ],
        ),
        _sliderbuilder(context, _gananciaMin, _gananciaMax, _porcGanancias),
        _radioPorcGanancia(context, _tipoGanancia),
        // Visibility(
        //   visible: _tipoGanancia == TipoGanancias.mensual,
        //   child: Row(
        //     children: <Widget>[
        //       Text('${AppLocalizations.of(context).months}:'),
        //       Counter(
        //         initialValue: _mesesCounter,
        //         minValue: 1,
        //         maxValue: 60,
        //         step: 1,
        //         decimalPlaces: 0,
        //         onChanged: (value) {
        //           BlocProvider.of<CalculationBloc>(context)
        //               .add(CambioMesesCounterEvent(value));
        //         },
        //       ),
        //       RaisedButton(
        //         child: Text('${AppLocalizations.of(context).reset}'),
        //         color: Colors.blueAccent,
        //         textColor: Colors.white,
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(18),
        //           side: BorderSide(color: Colors.blue),
        //         ),
        //         onPressed: () {
        //           BlocProvider.of<CalculationBloc>(context)
        //               .add(CambioMesesCounterEvent(1));
        //         },
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  _radioPorcGanancia(BuildContext context, TipoGanancias tipoGanancia) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: [
              Radio(
                value: TipoGanancias.diaria,
                groupValue: tipoGanancia,
                onChanged: (TipoGanancias value) {
                  BlocProvider.of<CalculationBloc>(context)
                      .add(TipoGananciaEvent(value));
                },
              ),
              Text('${AppLocalizations.of(context).daily}'),
            ],
          ),
          Row(
            children: [
              Radio(
                value: TipoGanancias.semanal,
                groupValue: tipoGanancia,
                onChanged: (TipoGanancias value) {
                  BlocProvider.of<CalculationBloc>(context)
                      .add(TipoGananciaEvent(value));
                },
              ),
              Text('${AppLocalizations.of(context).weekly}'),
            ],
          ),
          Row(
            children: [
              Radio(
                value: TipoGanancias.mensual,
                groupValue: tipoGanancia,
                onChanged: (TipoGanancias value) {
                  BlocProvider.of<CalculationBloc>(context)
                      .add(TipoGananciaEvent(value));
                },
              ),
              Text('${AppLocalizations.of(context).monthly}'),
            ],
          ),
        ],
      ),
    );
  }

  _infoPlatformWidget(BuildContext context, bool _infoPlatform) {
    return InfoIconButton(
      visibility: _infoPlatform,
      content: Text(
        AppLocalizations.of(context).infoPlatform,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () => BlocProvider.of<CalculationBloc>(context)
          .add(CambioInfoPlatformEvent()),
    );
  }

  _sliderbuilder(
      BuildContext context, double min, double max, double porcGanancias) {
    return Slider(
      label: '${porcGanancias.toStringAsFixed(2)}',
      min: min,
      max: max,
      divisions: 100,
      value: porcGanancias,
      onChanged: (value) {
        BlocProvider.of<CalculationBloc>(context)
            .add(PorcGnanaciasEvent(value));
      },
    );
  }
}
