

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zce/havadurumu/loacator.dart';
import 'package:zce/havadurumu/weather/tema/tema_bloc.dart';
import 'package:zce/mainhesaplama.dart';
import 'package:zce/screen/Login.dart';
import 'package:zce/screen/Mainpage.dart';
import 'package:zce/screen/Burcmain.dart';
import 'package:zce/views/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(BlocProvider<TemaBloc>(create: (BuildContext context) =>
      TemaBloc(),

    child: MaterialApp(
      initialRoute: "/",
      routes:{

        //  "/main" : (context) => MyApps(),

      },
      title: "ZCE APP",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.cyan,brightness: Brightness.dark,),
      home:Stepperwidget(), //Home(),//

    ),

  ));


}
