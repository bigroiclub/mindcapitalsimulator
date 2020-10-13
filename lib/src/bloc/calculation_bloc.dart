import 'package:bloc/bloc.dart';
import 'package:mindcapitalsimulator/src/model/referal_manager.dart';

import 'event/calculation_event.dart';
import 'state/calculation_state.dart';

enum TipoGanancias { diaria, semanal, mensual }

class CalculationBloc extends Bloc<CalculationEvent, CalculationState> {
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

  @override
  CalculationState get initialState {
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
        yield ReSimulationState(
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
            showPro: _showPro);
        // }
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
        yield ReSimulationState(
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
            showPro: _showPro);
        // }
      } catch (error) {
        yield error is CalculationStateError
            ? CalculationStateError(error.message)
            : CalculationStateError('Algo fue mal al realizar los calculos!');
      }
    } else if (event is CambioInfoPlatformEvent) {
      this._infoPlatform = !this._infoPlatform;
      yield ReSimulationState(
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
          showPro: _showPro);
    } else if (event is CambioInfoIntCompuestoEvent) {
      this._infoIntCompuesto = !this._infoIntCompuesto;
      yield ReSimulationState(
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
          showPro: _showPro);
    } else if (event is CambioInfoProfitEvent) {
      this._infoProfitButton = !this._infoProfitButton;
      yield ReSimulationState(
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
          showPro: _showPro);
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
      yield ReSimulationState(
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
          showPro: _showPro);
    } else if (event is PorcGnanaciasEvent) {
      this._porcGanancias = event.porcGanancias;
      _resetBeneficios();
      _calculaBeneficios(this._tipoGanancia);
      yield ReSimulationState(
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
          showPro: _showPro);
    } else if (event is FlagInteresCompuestoEvent) {
      _interesCompuestoFlag = !_interesCompuestoFlag;
      _resetBeneficios();
      _calculaBeneficios(_tipoGanancia);
      yield ReSimulationState(
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
          showPro: _showPro);
    } else if (event is CambioMesesCounterEvent) {
      _mesesCounter = event.mesesCounter;
      _isWithdrawExecuted = false;
      _resetBeneficios();
      _calculaBeneficios(_tipoGanancia);
      yield ReSimulationState(
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
          showPro: _showPro);
    } else if (event is ResetBeneficiosEvent) {
      _resetBeneficios();
      yield ReSimulationState(
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
          showPro: _showPro);
    } else if (event is CopyFutureContributionEvent) {
      _aportacion = _aportacionFutura;
      _resetBeneficios();
      _calculaBeneficios(_tipoGanancia);
      yield ReSimulationState(
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
          showPro: _showPro);
    } else if (event is ExpandPanelEvent) {
      _isExpanded = event.isExpanded;
      yield ReSimulationState(
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
          showPro: _showPro);
    } else if (event is CambioRetiroEvent) {
      _retiro = event.retiro;
      // if (_retiro == 0.0)
      //   _showRetiro = false;
      // else
      //   _showRetiro = true;
      _resetBeneficios();
      _calculaBeneficios(_tipoGanancia);
      yield ReSimulationState(
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
          showPro: _showPro);
    } else if (event is FlagProSettingsEvent) {
      _showPro = !_showPro;
      
      yield ReSimulationState(
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
          showPro: _showPro);
    }
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

    //TODO: Crear una clase InteresCompuesto que tenga en cuenta los 2 días en que no genera beneficios las nuevas aportaciones
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
