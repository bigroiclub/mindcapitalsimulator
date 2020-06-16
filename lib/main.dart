import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindcapitalsimulator/src/bloc/calculation_bloc.dart';
import 'package:mindcapitalsimulator/src/bloc/chart_bloc.dart';
import 'package:mindcapitalsimulator/src/bloc/home_bloc.dart';
import 'package:mindcapitalsimulator/src/dao/factory_dao.dart';
import 'package:mindcapitalsimulator/src/page/app.dart';

import 'src/dao/track_dao_impl.dart';

void main() {
  FactoryDao factoryDao = FactoryDao(trackDao: TrackDaoImpl());
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
      ],
      child: App()));
}