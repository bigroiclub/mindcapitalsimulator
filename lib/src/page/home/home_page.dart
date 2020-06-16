import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../home/home_mobile_page.dart';
import '../home/home_desktop_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: HomeMobilePage(),
      tablet: HomeDesktopPage(),
      desktop: HomeDesktopPage(),
    );
  }
}