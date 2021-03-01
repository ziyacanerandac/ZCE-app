import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'tema_event.dart';
part 'tema_state.dart';

class TemaBloc extends Bloc<TemaEvent, TemaState> {
  TemaBloc() : super(UygulamaTemasi(tema: ThemeData.dark(), renk: Colors.green));

  @override
  Stream<TemaState> mapEventToState(
    TemaEvent event,
  ) async* {
    UygulamaTemasi uygulamaTemasi;

    if(event is TemadegistirEvent)
      {
        switch(event.havadurumukisaltmasi)
        {
          case "sn"://karlı
          case "sl"://sulukar
          case "h"://dolu
          case "t"://fırıtna
          case "hc"://çok bulutlu
            uygulamaTemasi =UygulamaTemasi(tema: ThemeData(primaryColor: Colors.blueGrey), renk: Colors.grey);
            break;
          case "hr": //ağır yağmurlu
          case "lr"://hafif yağmurlu
            uygulamaTemasi =UygulamaTemasi(tema: ThemeData(primaryColor: Colors.indigoAccent), renk: Colors.indigo);
          break;
          case "lc"://az bulutlu
          case "c"://açık güneşli
          uygulamaTemasi =UygulamaTemasi(tema: ThemeData(primaryColor: Colors.orangeAccent), renk: Colors.yellow);
          break;
        }
        yield uygulamaTemasi;
      }
  }
}
