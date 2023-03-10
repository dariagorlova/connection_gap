import 'package:connection_gap/navigation.dart';
import 'package:connection_gap/presentation/bloc/connection/connection_bloc.dart';
import 'package:connection_gap/presentation/bloc/connection/connection_event.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectionBloc>(
          create: (context) =>
              ConnectionBloc(Connectivity())..add(ConnectionWatchdogEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationActions.navigatorKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: NavigationImpl().initialRoute,
        routes: NavigationImpl().routes,
        onGenerateRoute: NavigationImpl().onGenerateRoute,
      ),
    );
  }
}
