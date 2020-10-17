part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class SearchWeather extends WeatherEvent {
  final String cityName;

  const SearchWeather(this.cityName);

  @override
  List<Object> get props => [cityName];
}

class ResetWeather extends WeatherEvent{
  const ResetWeather();

  @override
  List<Object> get props => [];

}
