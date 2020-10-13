import 'package:mindcapitalsimulator/src/bloc/calculation_bloc.dart';

abstract class CalculationState {}

class CalculationInitState extends CalculationState {
  double beneficiosTotales;
  double beneficiosPlataforma;
  double beneficiosNetos;
  double beneficiosNetosReferidos;
  double gananciaMin;
  double gananciaMax;
  double porcGanancias;
  double aportacion;
  double aportacionFutura;
  double aportacionTotalReferido;
  TipoGanancias tipoGanancia;
  bool infoPlatform;
  bool infoIntCompuesto;
  bool interesCompuestoFlag;
  int mesesCounter;
  bool infoProfitButton;
  bool isExpanded;
  double retiro;
  double retiroTotal;
  bool overflow;

  CalculationInitState(
      {this.beneficiosTotales,
      this.beneficiosPlataforma,
      this.beneficiosNetos,
      this.beneficiosNetosReferidos,
      this.gananciaMin,
      this.gananciaMax,
      this.porcGanancias,
      this.aportacion,
      this.aportacionFutura,
      this.aportacionTotalReferido,
      this.tipoGanancia,
      this.infoPlatform,
      this.interesCompuestoFlag,
      this.mesesCounter,
      this.infoIntCompuesto,
      this.infoProfitButton,
      this.isExpanded,
      this.retiro,
      this.retiroTotal,
      this.overflow
      });

  @override
  String toString() => 'CalculationStateEmpty';
}

class ReSimulationState extends CalculationState {
  double aportacion;
  double aportacionFutura;
  double aportacionTotalReferido;
  double referLevel1;
  double referLevel2;
  double referLevel3;
  double referLevel4;
  double referLevel5;
  double referLevel6;
  double referLevel7;
  double referLevel8;
  double referLevel9;
  double referLevel10;
  double beneficiosTotales;
  double beneficiosPlataforma;
  double beneficiosNetos;
  double beneficiosNetosReferidos;
  double porcGanancias;
  bool interesCompuestoFlag;
  int mesesCounter;
  double gananciaMin;
  double gananciaMax;
  TipoGanancias tipoGanancias;
  bool infoPlatform;
  bool infoIntCompuesto;
  bool infoProfitButton;
  bool isExpanded;
  bool showRetiro;
  double retiro;
  double retiroTotal;
  bool overflow;
  bool showPro;

  ReSimulationState(
      {this.aportacion,
      this.aportacionFutura,
      this.aportacionTotalReferido,
      this.referLevel1,
      this.referLevel2,
      this.referLevel3,
      this.referLevel4,
      this.referLevel5,
      this.referLevel6,
      this.referLevel7,
      this.referLevel8,
      this.referLevel9,
      this.referLevel10,
      this.beneficiosTotales,
      this.beneficiosPlataforma,
      this.beneficiosNetos,
      this.beneficiosNetosReferidos,
      this.porcGanancias,
      this.interesCompuestoFlag,
      this.mesesCounter,
      this.gananciaMin,
      this.gananciaMax,
      this.tipoGanancias,
      this.infoPlatform,
      this.infoIntCompuesto,
      this.infoProfitButton,
      this.isExpanded,
      this.showRetiro,
      this.retiro,
      this.retiroTotal,
      this.overflow,
      this.showPro
      });
  @override
  String toString() => 'Calculation State';
}

class CalculationStateError extends CalculationState {
  final String message;

  CalculationStateError(this.message);

  @override
  String toString() => 'CalculationStateError';
}
