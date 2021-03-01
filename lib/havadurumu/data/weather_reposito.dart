import 'package:zce/havadurumu/data/weather_api_client.dart';
import 'package:zce/havadurumu/loacator.dart';
import 'package:zce/havadurumu/models/weather_model.dart';


class WeatherRepository{
  WeatherApiClient weatherApiClient=locator<WeatherApiClient>();
  Future<Weather> getWeather(String sehir) async{
   final int sehirID = await weatherApiClient.getLocationID(sehir);
   return await weatherApiClient.getWeather(sehirID);

  }
}