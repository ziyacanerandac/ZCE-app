import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:zce/havadurumu/weather/weather_bloc.dart';
import 'package:intl/intl.dart';
class SonguncellenenWidget extends StatefulWidget {

  int ide;
  SonguncellenenWidget({Key key,this.ide}):super(key:key);

  @override
  _SonguncellenenWidgetState createState() => _SonguncellenenWidgetState();
}

class _SonguncellenenWidgetState extends State<SonguncellenenWidget> {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('tr');
    final _weatherbloc=BlocProvider.of<WeatherBloc>(context);
    return BlocBuilder(
      cubit: _weatherbloc,
      builder: (context,WeatherState state){
        var gun =(state as WeatherLoadedstate).weather.consolidatedWeather[widget.ide].applicableDate;
        var yeniTarih =(state as WeatherLoadedstate).weather.time.toLocal();
        return Column(
          children: [
            Text("Son güncellenen:"+  TimeOfDay.fromDateTime(yeniTarih).format(context),
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            Text("Tarih:"+ DateFormat.yMMMEd('tr_TR').format(gun),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),


          ],
        );
      }

    );
  }
}
