import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../login/login_desktop_page.dart';
import '../login/login_mobile_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: LoginMobilePage(),
      tablet: LoginDesktopPage(),
      desktop: LoginDesktopPage(),
      );
  }
}