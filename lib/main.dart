import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindcapitalsimulator/src/bloc/calculation_bloc.dart';
import 'package:mindcapitalsimulator/src/bloc/chart_bloc.dart';
import 'package:mindcapitalsimulator/src/bloc/home_bloc.dart';
import 'package:mindcapitalsimulator/src/bloc/login_bloc.dart';
import 'package:mindcapitalsimulator/src/dao/factory_dao.dart';
import 'package:mindcapitalsimulator/src/dao/login_dao_impl.dart';
import 'package:mindcapitalsimulator/src/page/app.dart';
import 'package:mindcapitalsimulator/src/repository/firebase_messaging_impl.dart';
import 'package:mindcapitalsimulator/src/repository/preferences_impl.dart';

import 'src/dao/track_dao_impl.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final PreferencesInterfaceImpl _prefs = PreferencesInterfaceImpl();
  await _prefs.initPreferences();

  final FirebaseMessagingImpl _messaging = FirebaseMessagingImpl();
  _messaging.initialise();
  _messaging.getDeviceToken();
  FactoryDao factoryDao = FactoryDao(trackDao: TrackDaoImpl(), loginDao: LoginDaoImpl());
  runApp(MultiBlocProvider(
      providers: [  
        BlocProvider<CalculationBloc>(
          create: (context) => CalculationBloc(),
        ),
        BlocProvider<ChartBloc>(
          create: (context) => ChartBloc(factoryDao),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(preferences: _prefs, factoryDao: factoryDao),
        ),
      ],
      child: App()));
}