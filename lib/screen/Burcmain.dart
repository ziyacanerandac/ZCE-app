import 'package:flutter/material.dart';
import 'package:zce/screen/Mainpage.dart';
import 'package:zce/screen/burc_detay.dart';
import 'package:zce/screen/burc_liste.dart';
//import 'package:real_project_1/testlib.dart';

//void main() => runApp(MyApps());


class MyApps extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Burc Rehberi",
      debugShowCheckedModeBanner: false,

      initialRoute: "/burcListesi",

      routes: {
        "/" : (context) => BurcListesi(),
        "/burcListesi" : (context) => BurcListesi(),

        "/" : (context) => Mainpage(),
        "/burcListesi" : (context) => BurcListesi(),
        "/main": (context) => MyApps(),
      },

      onGenerateRoute: (RouteSettings settings){
        List<String> pathElemanlari = settings.name.split("/"); //  /  burcDetay  /    1
        if(pathElemanlari[1] == 'burcDetay'){
          return MaterialPageRoute(builder: (context) => BurcDetay(int.parse(pathElemanlari[2])));
        }
        return null;
      },

      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.pink,
      ),

    );
  }

}