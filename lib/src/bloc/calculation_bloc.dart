import 'package:bloc/bloc.dart';
import 'package:mindcapitalsimulator/src/model/referal_manager.dart';
import 'package:mindcapitalsimulator/src/repository/preferences_impl.dart';

import 'event/calculation_event.dart';
import 'state/calculation_state.dart';

enum TipoGanancias { diaria, semanal, mensual }

class CalculationBloc extends Bloc<CalculationEvent, CalculationState> {
  final PreferencesInterfaceImpl preferences;
  static const double PORC_PLATAFORMA = 35;
  static const double PORC_INVERSOR = 65;
  static const double MAX_APORTACION = 100000;
  double _beneficiosTotales = 0.0;
  double _beneficiosPlataforma = 0.0;
  double _beneficiosNetos = 0.0;
  double _beneficiosNetosReferidos = 0.0;
  ReferalManager _referalManager = ReferalManager();
  double _gananciaMin = 0.5;
  double _gananciaMax = 1.5;
  double _porcGanancias = 1.0;
  double _aportacion = 0;
  double _aportacionFutura = 0.0;
  TipoGanancias _tipoGanancia = TipoGanancias.diaria;
  bool _infoPlatform = false;
  bool _infoIntCompuesto = false;
  bool _interesCompuestoFlag = false;
  bool _infoProfitButton = false;
  int _mesesCounter = 1;
  bool _isExpanded = false;
  bool _showRetiro = false;
  double _retiro = 0.0;
  double _retiroTotal = 0.0;
  bool _isWithdrawExecuted = false;
  bool _overflow = false;
  bool _showPro = false;

  CalculationBloc({this.preferences});

  @override
  CalculationState get initialState {
    _getCockpitData();
    _calculaBeneficios(this._tipoGanancia);

    return CalculationInitState(
        beneficiosTotales: this._beneficiosTotales,
        beneficiosPlataforma: this._beneficiosPlataforma,
        beneficiosNetos: this._beneficiosNetos,
        beneficiosNetosReferidos: this._beneficiosNetosReferidos,
        gananciaMin: this._gananciaMin,
        gananciaMax: this._gananciaMax,
        porcGanancias: this._porcGanancias,
        aportacion: this._aportacion,
        aportacionFutura: this._aportacionFutura,
        aportacionTotalReferido: this._referalManager.total,
        tipoGanancia: this._tipoGanancia,
        referLevel1: _referalManager.level_1,
        referLevel2: _referalManager.level_2,
        referLevel3: _referalManager.level_3,
        referLevel4: _referalManager.level_4,
        referLevel5: _referalManager.level_5,
        referLevel6: _referalManager.level_6,
        referLevel7: _referalManager.level_7,
        referLevel8: _referalManager.level_8,
        referLevel9: _referalManager.level_9,
        referLevel10: _referalManager.level_10,
        infoPlatform: this._infoPlatform,
        infoIntCompuesto: this._infoIntCompuesto,
        infoProfitButton: this._infoProfitButton,
        interesCompuestoFlag: this._interesCompuestoFlag,
        mesesCounter: this._mesesCounter,
        isExpanded: _isExpanded,
        retiro: _retiro,
        retiroTotal: _retiroTotal,
        overflow: _overflow);
  }

  @override
  Stream<CalculationState> mapEventToState(CalculationEvent event) async* {
    if (event is CambioAportacionEvent) {
      try {
        _aportacion = event.aportacion;
        // if(_aportacion < 100)
        //   yield CalculationStateError('La aportación mínima son 100\$');
        // else if (_aportacion > 100000)
        //   yield CalculationStateError('La aportación máxima son 100.000\$');
        // else{
        _resetBeneficios();
        _calculaBeneficios(_tipoGanancia);
        yield _resimulationState();
      } catch (error) {
        yield error is CalculationStateError
            ? CalculationStateError(error.message)
            : CalculationStateError('Algo fue mal al realizar los calculos!');
      }
    } else if (event is CambioAportacionReferidoEvent) {
      try {
        _resetBeneficios();

        switch (event.index) {
          case 1:
            _referalManager.level_1 = event.aportacionReferido;
            break;
          case 2:
            _referalManager.level_2 = event.aportacionReferido;
            break;
          case 3:
            _referalManager.level_3 = event.aportacionReferido;
            break;
          case 4:
            _referalManager.level_4 = event.aportacionReferido;
            break;
          case 5:
            _referalManager.level_5 = event.aportacionReferido;
            break;
          case 6:
            _referalManager.level_6 = event.aportacionReferido;
            break;
          case 7:
            _referalManager.level_7 = event.aportacionReferido;
            break;
          case 8:
            _referalManager.level_8 = event.aportacionReferido;
            break;
          case 9:
            _referalManager.level_9 = event.aportacionReferido;
            break;

          case 10:
            _referalManager.level_10 = event.aportacionReferido;
            break;
          default:
        }

        _calculaBeneficios(_tipoGanancia);
        yield _resimulationState();
      } catch (error) {
        yield error is CalculationStateError
            ? CalculationStateError(error.message)
            : CalculationStateError('Algo fue mal al realizar los calculos!');
      }
    } else if (event is CambioInfoPlatformEvent) {
      this._infoPlatform = !this._infoPlatform;
      yield _resimulationState();
    } else if (event is CambioInfoIntCompuestoEvent) {
      this._infoIntCompuesto = !this._infoIntCompuesto;
      yield _resimulationState();
    } else if (event is CambioInfoProfitEvent) {
      this._infoProfitButton = !this._infoProfitButton;
      yield _resimulationState();
    } else if (event is TipoGananciaEvent) {
      this._tipoGanancia = event.tipoGanancia;
      this._showRetiro = false;

      switch (this._tipoGanancia) {
        case TipoGanancias.semanal:
          this._porcGanancias = 6.0;
          _gananciaMin = 2.5;
          _gananciaMax = 7.5;
          _retiro = 0.0;
          break;

        case TipoGanancias.mensual:
          this._porcGanancias = 20.0;
          _gananciaMin = 10;
          _gananciaMax = 30;

          _showRetiro = true;

          break;
        default:
          this._porcGanancias = 1.0;
          _gananciaMin = 0.5;
          _gananciaMax = 1.5;
          _retiro = 0.0;
      }
      _resetBeneficios();
      _calculaBeneficios(this._tipoGanancia);
      yield _resimulationState();
    } else if (event is PorcGnanaciasEvent) {
      this._porcGanancias = event.porcGanancias;
      _resetBeneficios();
      _calculaBeneficios(this._tipoGanancia);
      yield _resimulationState();
    } else if (event is FlagInteresCompuestoEvent) {
      _interesCompuestoFlag = !_interesCompuestoFlag;
      _resetBeneficios();
      _calculaBeneficios(_tipoGanancia);
      yield _resimulationState();
    } else if (event is CambioMesesCounterEvent) {
      _mesesCounter = event.mesesCounter;
      _isWithdrawExecuted = false;
      _resetBeneficios();
      _calculaBeneficios(_tipoGanancia);
      yield _resimulationState();
    } else if (event is ResetBeneficiosEvent) {
      _resetBeneficios();
      yield _resimulationState();
    } else if (event is CopyFutureContributionEvent) {
      _aportacion = _aportacionFutura;
      _resetBeneficios();
      _calculaBeneficios(_tipoGanancia);
      yield _resimulationState();
    } else if (event is ExpandPanelEvent) {
      _isExpanded = event.isExpanded;
      yield _resimulationState();
    } else if (event is CambioRetiroEvent) {
      _retiro = event.retiro;
      // if (_retiro == 0.0)
      //   _showRetiro = false;
      // else
      //   _showRetiro = true;
      _resetBeneficios();
      _calculaBeneficios(_tipoGanancia);
      yield _resimulationState();
    } else if (event is FlagProSettingsEvent) {
      _showPro = !_showPro;

      yield _resimulationState();
    } else if (event is ResetDataEvent) {
      _resetData();
      _resetCockpitData();
      _resetBeneficios();
      yield _resimulationState(resetData: true);
    }
  }

  CalculationState _resimulationState({bool resetData=false}) {
    this.preferences.saveCockpitData(
          _aportacion,
          _porcGanancias,
          _gananciaMin,
          _gananciaMax,
          _retiro,
          _tipoGanancia.toString(),
          _referalManager.level_1,
          _referalManager.level_2,
          _referalManager.level_3,
          _referalManager.level_4,
          _referalManager.level_5,
          _referalManager.level_6,
          _referalManager.level_7,
          _referalManager.level_8,
          _referalManager.level_9,
          _referalManager.level_10,
        );
    return ReSimulationState(
        aportacion: _aportacion,
        aportacionFutura: _aportacionFutura,
        beneficiosTotales: _beneficiosTotales,
        aportacionTotalReferido: _referalManager.total,
        referLevel1: _referalManager.level_1,
        referLevel2: _referalManager.level_2,
        referLevel3: _referalManager.level_3,
        referLevel4: _referalManager.level_4,
        referLevel5: _referalManager.level_5,
        referLevel6: _referalManager.level_6,
        referLevel7: _referalManager.level_7,
        referLevel8: _referalManager.level_8,
        referLevel9: _referalManager.level_9,
        referLevel10: _referalManager.level_10,
        beneficiosPlataforma: _beneficiosPlataforma,
        beneficiosNetos: _beneficiosNetos,
        beneficiosNetosReferidos: _beneficiosNetosReferidos,
        porcGanancias: _porcGanancias,
        interesCompuestoFlag: _interesCompuestoFlag,
        mesesCounter: _mesesCounter,
        gananciaMin: _gananciaMin,
        gananciaMax: _gananciaMax,
        tipoGanancias: _tipoGanancia,
        infoPlatform: _infoPlatform,
        infoIntCompuesto: _infoIntCompuesto,
        infoProfitButton: _infoProfitButton,
        isExpanded: _isExpanded,
        showRetiro: _showRetiro,
        retiro: _retiro,
        retiroTotal: _retiroTotal,
        overflow: _overflow,
        showPro: _showPro,
        resetData: resetData);
  }

  _calculaBeneficios(TipoGanancias tipoGanancias) {
    //tipoCompuesto
    switch (tipoGanancias) {
      case TipoGanancias.semanal:
        double porcGananciaDiaria = _porcGanancias / 5;

        for (var i = 0; i < 5; i++)
          _calculaBeneficiosDiaria(porcGananciaDiaria);
        break;

      case TipoGanancias.mensual:
        //De los meses introducidos por el usuario se calculan los días hábiles
        var diasHabiles = 20;
        double porcGananciaDiaria = _porcGanancias / 20;

        for (var i = 0; i < _mesesCounter; i++) {
          _isWithdrawExecuted = false;
          for (var t = 0; t < diasHabiles; t++)
            _calculaBeneficiosDiaria(porcGananciaDiaria);

          // _beneficiosTotales = _beneficiosTotales * _mesesCounter;
          // _beneficiosPlataforma = _beneficiosPlataforma * _mesesCounter;
          // _beneficiosNetosReferidos = _beneficiosNetosReferidos * _mesesCounter;
          // _beneficiosNetos = _beneficiosNetos * _mesesCounter;
          // _retiroTotal = _retiroTotal * _mesesCounter;
        }

        // _retiroTotal = _retiroTotal * _mesesCounter;
        break;
      default:
        _calculaBeneficiosDiaria(_porcGanancias);
    }
  }

  _calculaBeneficiosDiaria(porcGanancias) {
    double beneficiosTotales =
        (_aportacion + _aportacionFutura) * (porcGanancias / 100);
    double beneficiosPlataforma = beneficiosTotales * (PORC_PLATAFORMA / 100);
    double beneficiosNetos = beneficiosTotales * (PORC_INVERSOR / 100);
    double beneficiosNetosReferidos =
        _referalManager.profit(porcGanancias, PORC_INVERSOR);

    bool out = false;

    _beneficiosTotales =
        _beneficiosTotales + beneficiosTotales + beneficiosNetosReferidos;
    _beneficiosPlataforma = _beneficiosPlataforma + beneficiosPlataforma;
    _beneficiosNetosReferidos =
        _beneficiosNetosReferidos + beneficiosNetosReferidos;
    _beneficiosNetos =
        _beneficiosNetos + beneficiosNetos + beneficiosNetosReferidos;

    if (_executeCompound(_interesCompuestoFlag)) {
      if (_executeWithdraw(
          _showRetiro, _beneficiosNetos, _retiro, _isWithdrawExecuted)) {
        if (_showRetiro && !_isWithdrawExecuted) {
          // Si los beneficios superan al retiro se descuenta y se empieza el interes compuesto
          _beneficiosNetos = _beneficiosNetos - _retiro;
          _retiroTotal = _retiroTotal + _retiro;
          _isWithdrawExecuted = true;
        }
        while (out == false) {
          if ((_aportacionFutura + _aportacion) >= MAX_APORTACION) {
            _overflow = true;
            out = true;
          } else if (_beneficiosNetos >= 110) {
            _beneficiosNetos = _beneficiosNetos - 10;
            _aportacionFutura = _aportacionFutura + 10;
          } else if (_beneficiosNetos >= 100) {
            _beneficiosNetos = _beneficiosNetos - 100;
            _aportacionFutura = _aportacionFutura + 100;
          } else {
            out = true;
          }
        }
      }
    } else {
      if (_executeWithdraw(
          _showRetiro, _beneficiosNetos, _retiro, _isWithdrawExecuted)) {
        if (_showRetiro && !_isWithdrawExecuted) {
          // Si los beneficios superan al retiro se descuenta
          _beneficiosNetos = _beneficiosNetos - _retiro;
          _retiroTotal = _retiroTotal + _retiro;
          _isWithdrawExecuted = true;
        }
      }
    }

    // print('beneficios Netos: ' + '$_beneficiosNetos');
    // print('Aportacion Futura: ' + '$_aportacionFutura');
  }

  bool _executeCompound(bool interesCompuestoFlag) {
    if (interesCompuestoFlag) {
      return true;
    } else {
      return false;
    }
  }

  bool _executeWithdraw(bool showRetiro, double beneficiosNetos, double retiro,
      bool isWithdrawExecuted) {
    if (showRetiro) {
      // Se ha informado de un retiro
      if (_isWithdrawExecuted)
        return true;
      else {
        if (beneficiosNetos < retiro && retiro > 0.0)
          return false;
        else
          return true;
      }
    } else
      return true;
  }

  _getCockpitData(){
    _aportacion = this.preferences.getDouble('aportacion');
    _retiro = this.preferences.getDouble('retiro');
    _porcGanancias = this.preferences.getDouble('porcGanancias');
    _gananciaMin = this.preferences.getDouble('gananciaMin');
    _gananciaMax = this.preferences.getDouble('gananciaMax');
    String tipoGanancia = this.preferences.getString('tipoGanancia');
    _tipoGanancia = _tipoGananciaFromString(tipoGanancia);
    _referalManager.level_1 = this.preferences.getDouble('referal1');
    _referalManager.level_2 = this.preferences.getDouble('referal2');
    _referalManager.level_3 = this.preferences.getDouble('referal3');
    _referalManager.level_4 = this.preferences.getDouble('referal4');
    _referalManager.level_5 = this.preferences.getDouble('referal5');
    _referalManager.level_6 = this.preferences.getDouble('referal6');
    _referalManager.level_7 = this.preferences.getDouble('referal7');
    _referalManager.level_8 = this.preferences.getDouble('referal8');
    _referalManager.level_9 = this.preferences.getDouble('referal9');
    _referalManager.level_10 = this.preferences.getDouble('referal10');
  }

  TipoGanancias _tipoGananciaFromString(String value) {
    TipoGanancias tipoGanancia;
    switch (value) {
      case 'TipoGanancias.mensual':
        tipoGanancia = TipoGanancias.mensual;
        break;
      case 'TipoGanancias.semanal':
        tipoGanancia = TipoGanancias.semanal;
        break;
      default:
        tipoGanancia = TipoGanancias.diaria;
    }

    return tipoGanancia;
  }

  _resetData() {
    _aportacion = 0.0;
    _retiro = 0.0;
    _referalManager.clear();
    _porcGanancias = 1.0;
    _gananciaMin = 0.5;
    _gananciaMax = 1.5;
    _tipoGanancia = TipoGanancias.diaria;
  }

  _resetCockpitData() {
    this.preferences.resetCockpitData();
  }

  _resetBeneficios() {
    _aportacionFutura = 0.0;
    _beneficiosTotales = 0.0;
    _beneficiosPlataforma = 0.0;
    _beneficiosNetos = 0.0;
    _beneficiosNetosReferidos = 0.0;
    _retiroTotal = 0.0;
    _isWithdrawExecuted = false;
    _overflow = false;
    // _referalManager.clear();
  }
}
