import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:zce/havadurumu/data/weather_reposito.dart';
import 'package:zce/havadurumu/loacator.dart';
import 'package:zce/havadurumu/models/weather_model.dart';


part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial());
  final WeatherRepository weatherRepository=locator<WeatherRepository>();



  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if(event is FetchWeatherEvent )
      {
        yield WeatherLoadingstate();
        try{
          final Weather getirilenwether = await weatherRepository.getWeather(event.sehirAdi);
          weatherRepository.getWeather(event.sehirAdi);
          yield WeatherLoadedstate(weather:getirilenwether);

        }catch(_){
          yield Weathererrorstate();

        }
      }
     else if(event is RefleshFetchWeatherEvent )
    {

      try{
        final Weather getirilenwether = await weatherRepository.getWeather(event.sehirAdi);
        weatherRepository.getWeather(event.sehirAdi);
        yield WeatherLoadedstate(weather:getirilenwether);

      }catch(_){
        yield state;

      }
    }
  }
}
