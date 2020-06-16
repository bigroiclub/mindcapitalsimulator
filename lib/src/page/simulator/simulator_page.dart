import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'simulator_desktop_page.dart';
import 'simulator_mobile_page.dart';

class SimulatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: SimulatorMobilePage(),
      tablet: SimulatorDesktopPage(),
      desktop: SimulatorDesktopPage(),
    );
  }
}