import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zce/havadurumu/weather/weather_bloc.dart';

class MaxminsicaklikWidget extends StatefulWidget {
  int ide;
  MaxminsicaklikWidget({Key key,this.ide}):super(key:key);

  @override
  _MaxminsicaklikWidgetState createState() => _MaxminsicaklikWidgetState();
}

class _MaxminsicaklikWidgetState extends State<MaxminsicaklikWidget> {
  @override
  Widget build(BuildContext context) {
    final _weatherbloc = BlocProvider.of<WeatherBloc>(context);

    return BlocBuilder(
      cubit: _weatherbloc,
      builder: (context,WeatherState state){
        return Row(
          mainAxisAlignment:MainAxisAlignment.spaceBetween ,
          children: [
            Text("Maximum :"+(state as WeatherLoadedstate).weather.consolidatedWeather[widget.ide].maxTemp.floor().toString()+"°C",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),),
            Text("Minumum :"+(state as WeatherLoadedstate).weather.consolidatedWeather[widget.ide].minTemp.floor().toString()+"°C",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),),

          ],
        );
      },

    );
  }
}
