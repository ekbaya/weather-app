import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/data/models/Weather.dart';
import 'package:weather_app/data/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc(this.weatherRepository) : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    yield WeatherLoading();
    if(event is SearchWeather){
      try{
        final weather = await weatherRepository.seachWeather(event.cityName);
        yield WeatherLoaded(weather);
        
      }on NetworkError{
        yield WeatherError("Failed to load weather, is your device online ?");
      }
    }
    else if(event is ResetWeather){
      yield WeatherInitial();
    }
  }
}
