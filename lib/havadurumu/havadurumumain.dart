import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zce/havadurumu/loacator.dart';
import 'package:zce/havadurumu/weather/tema/tema_bloc.dart';
import 'package:zce/havadurumu/weather/weather_bloc.dart';
import 'package:zce/havadurumu/widget/weather_app.dart';



class havadurumu extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _havadurumuState createState() => _havadurumuState();
}

class _havadurumuState extends State<havadurumu> {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder(

      cubit: BlocProvider.of<TemaBloc>(context),
      builder: (context,TemaState state){
       return MaterialApp(
          title: "ZCE APP",
          debugShowCheckedModeBanner: false,
          theme:(state as UygulamaTemasi).tema,
          home:BlocProvider<WeatherBloc>(
              create: (context)=>WeatherBloc(),
              child: WeatherApp()
          ),
        );
      }

    );
  }
}

