abstract class ChartEvent {}

class ChartEventEmpty extends ChartEvent {
  @override
  String toString() => 'Empty Event';
}

class FetchChartEvent extends ChartEvent {
  @override
  String toString() => 'Fetch Chart Event';
}

class SimulatorResultChangeEvent extends ChartEvent {
  final String aportacionInicialText;
  final double aportacionInicial;
  final double beneficiosNetos;
  final double aportacionFutura;
  final bool interesCompuestoFlag;
  final double beneficiosNetosReferidos;
  final String beneficiosNetosText;
  final String intCompuestoText;
  final String beneficiosTotalesText;
  final double beneficiosTotales;
  final String beneficiosPlataformaText;
  final double beneficiosPlataforma;
  final String referidosText;
  final bool overflow;

  SimulatorResultChangeEvent(
      {this.aportacionInicialText,
      this.aportacionInicial,
      this.beneficiosNetosText,
      this.intCompuestoText,
      this.referidosText,
      this.beneficiosNetos,
      this.aportacionFutura,
      this.interesCompuestoFlag,
      this.beneficiosTotalesText,
      this.beneficiosTotales,
      this.beneficiosPlataformaText,
      this.beneficiosPlataforma,
      this.beneficiosNetosReferidos,
      this.overflow
      });

  @override
  String toString() => 'Simulate Chart Event';
}
