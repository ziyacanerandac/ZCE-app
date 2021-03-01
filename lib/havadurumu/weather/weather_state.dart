part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState([List<Weather> list]);
}

class WeatherInitial extends WeatherState {
  @override
  List<Object> get props => [];
}
class WeatherLoadingstate extends WeatherState {
  @override
  // TODO: implement props
  List<Object> get props =>[];
}

class WeatherLoadedstate extends WeatherState {
  final Weather weather;
  WeatherLoadedstate({@required this.weather}):super([weather]);

  @override
  // TODO: implement props
  List<Object> get props => [weather];
}
class Weathererrorstate extends WeatherState {
  @override
  // TODO: implement props
  List<Object> get props => [];

}
