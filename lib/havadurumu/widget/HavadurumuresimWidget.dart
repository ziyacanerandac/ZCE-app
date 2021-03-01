import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zce/havadurumu/weather/weather_bloc.dart';


class HavadurumuresimWidget extends StatefulWidget {

 int ide;
 HavadurumuresimWidget({Key key,this.ide}):super(key:key);

  @override
  _HavadurumuresimWidgetState createState() => _HavadurumuresimWidgetState();
}

class _HavadurumuresimWidgetState extends State<HavadurumuresimWidget> {
  @override
  Widget build(BuildContext context) {

    final _weatherbloc = BlocProvider.of<WeatherBloc>(context);


    return BlocBuilder(
        cubit: _weatherbloc,
        builder: (context, WeatherState state) {
         return Column(
           children: [
             Text((state as WeatherLoadedstate).weather.consolidatedWeather[widget.ide].theTemp.floor().toString()+"°C",style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold),),
         Image.network(
         "https://www.metaweather.com/static/img/weather/png/" +
         (state as WeatherLoadedstate)
             .weather
             .consolidatedWeather[widget.ide]
             .weatherStateAbbr +
             ".png",
          width: 200,
          height: 200,

          ),
           ],

         );
        });
  }
}
