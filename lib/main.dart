import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/weather_repository.dart';
import 'package:weather_app/pages/weather_search.dart';
import 'bloc/weather_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.grey[900],
          body: BlocProvider(
            create: (context) => WeatherBloc(WeatherRepository()),
            child: WeatherSearchPage(),
          ),
        ));
  }
}
