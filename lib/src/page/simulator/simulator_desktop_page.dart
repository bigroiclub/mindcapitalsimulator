import 'package:flutter/material.dart';
import 'package:mindcapitalsimulator/src/page/simulator/widget/simulator_cockpit_widget.dart';
import 'package:mindcapitalsimulator/src/page/simulator/widget/simulator_result_widget.dart';

class SimulatorDesktopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        flex: 1,
        child: SimulatorCockpitWidget(),
      ),
      Expanded(
        flex: 2,
        child: SimulatorResultWidget(),
      ),
    ]);
  }
}
