import 'package:mindcapitalsimulator/src/bloc/calculation_bloc.dart';

abstract class CalculationEvent{
}

class CalculationEventEmpty extends CalculationEvent{
  @override
  String toString() => 'Empty State';
}

class CambioAportacionEvent extends CalculationEvent{
  double aportacion;

  CambioAportacionEvent({this.aportacion});
  @override
  String toString() => 'Cambio Aportacion Event';
}

class CambioAportacionReferidoEvent extends CalculationEvent{
  int index;
  double aportacionReferido;

  CambioAportacionReferidoEvent({this.index, this.aportacionReferido});
  @override
  String toString() => 'Cambio Aportacion aportacionReferido Event';
}

class CambioInfoPlatformEvent extends CalculationEvent{
  CambioInfoPlatformEvent();
  @override
  String toString() => 'Cambio info Plataforma Event';
}

class CambioInfoIntCompuestoEvent extends CalculationEvent{
  CambioInfoIntCompuestoEvent();
  @override
  String toString() => 'Cambio info Interés compuesto Event';
}

class CambioInfoProfitEvent extends CalculationEvent{
  CambioInfoProfitEvent();
  @override
  String toString() => 'Cambio info beneficios Event';
}

class TipoGananciaEvent extends CalculationEvent{
  TipoGanancias tipoGanancia;

  TipoGananciaEvent(this.tipoGanancia);
  @override
  String toString() => 'TipoGananciaEvent Event';
}

class PorcGnanaciasEvent extends CalculationEvent{
  double porcGanancias;

  PorcGnanaciasEvent(this.porcGanancias);
   @override
  String toString() => 'PorcGnanaciasEventEvent';
}

class FlagInteresCompuestoEvent extends CalculationEvent{
   @override
  String toString() => 'FlagInteresCompuestoEvent Event';
}

class CambioMesesCounterEvent extends CalculationEvent{
  int mesesCounter;

  CambioMesesCounterEvent(this.mesesCounter);
  @override
  String toString() => 'CambioMesesCounterEvent Event';
}

class ResetBeneficiosEvent extends CalculationEvent{

  ResetBeneficiosEvent();
  @override
  String toString() => 'ResetBeneficiosEvent Event';
}

class CopyFutureContributionEvent extends CalculationEvent{

  CopyFutureContributionEvent();
  @override
  String toString() => 'CopyFutureContributionEvent Event';
}

class ExpandPanelEvent extends CalculationEvent{
  final bool isExpanded;

  ExpandPanelEvent(this.isExpanded);
  @override
  String toString() => 'ExpandPanelEvent Event';
}