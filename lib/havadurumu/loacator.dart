import 'package:get_it/get_it.dart';
import 'package:zce/havadurumu/data/weather_api_client.dart';
import 'package:zce/havadurumu/data/weather_reposito.dart';

GetIt locator=GetIt.instance;
void setupLocator(){
  locator.registerLazySingleton(() => WeatherRepository());
  locator.registerLazySingleton(() => WeatherApiClient());
}