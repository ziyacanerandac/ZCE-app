
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zce/havadurumu/models/weather_model.dart';

class WeatherApiClient{
 static const baseUrl="https://www.metaweather.com";
 final http.Client httpClient=http.Client();
 Future<int> getLocationID(String sehirAdi) async{
   final sehirURL=baseUrl+"/api/location/search/?query="+sehirAdi;
   final gelencevap=await httpClient.get(sehirURL);
   if(gelencevap.statusCode!=200){
     throw Exception("Veri getirilemedi");
   }
  final gelenCevapJson=(jsonDecode(gelencevap.body)) as List;
   return gelenCevapJson[0]["woeid"];
 }
 Future<Weather>getWeather(int sehirID) async{
   final havaDurumuURL=baseUrl+"/api/location/$sehirID";
   final havadurumugelencevap=await httpClient.get(havaDurumuURL);
   if(havadurumugelencevap.statusCode!=200){
     throw Exception("Hava Durumu Getirilemedi");
   }
   final havadurumucevapjson=jsonDecode(havadurumugelencevap.body);
   return Weather.fromJson(havadurumucevapjson);
 }

}