part of 'weather_bloc.dart';
@immutable
abstract class WeatherEvent extends Equatable {
  const WeatherEvent([List<String> list]);


}
class FetchWeatherEvent extends WeatherEvent{
  final String sehirAdi;

  FetchWeatherEvent({@required this.sehirAdi}):super([sehirAdi]);
  @override
  // TODO: implement props
  List<Object> get props => [this.sehirAdi];
}
class RefleshFetchWeatherEvent extends WeatherEvent{
  final String sehirAdi;

  RefleshFetchWeatherEvent({@required this.sehirAdi}):super([sehirAdi]);
  @override
  // TODO: implement props
  List<Object> get props => [this.sehirAdi];
}