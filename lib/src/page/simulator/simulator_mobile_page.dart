import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindcapitalsimulator/src/bloc/home_bloc.dart';
import 'package:mindcapitalsimulator/src/bloc/state/home_state.dart';
import 'package:mindcapitalsimulator/src/page/simulator/widget/simulator_cockpit_widget.dart';
import 'package:mindcapitalsimulator/src/page/simulator/widget/simulator_result_widget.dart';

class SimulatorMobilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        builder: (BuildContext context, state) {
      if (state is CalculateState) {
        return SimulatorResultWidget(withCalcButton: true);
      }

      return SimulatorCockpitWidget(withCalcButton: true);
    });
  }
}
