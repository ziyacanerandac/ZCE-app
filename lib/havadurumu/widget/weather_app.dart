import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zce/havadurumu/weather/tema/tema_bloc.dart';
import 'package:zce/havadurumu/weather/weather_bloc.dart';
import 'package:zce/havadurumu/widget/HavadurumuresimWidget.dart';
import 'package:zce/havadurumu/widget/Maxminsicaklik_Widget.dart';
import 'package:zce/havadurumu/widget/gecisli_arkaplan_renk.dart';
import 'package:zce/havadurumu/widget/loaction_widget.dart';
import 'package:zce/havadurumu/widget/sehir_sec.dart';
import 'package:zce/havadurumu/widget/songuncellenen_widget.dart';


class WeatherApp extends StatelessWidget {
  String kullanicininsectigisehir = "";
  Completer <void> _refreshCompleter =Completer<void>();

  int i=0;
  @override
  Widget build(BuildContext context) {
    final _weatherbloc=BlocProvider.of<WeatherBloc>(context);
    return BlocBuilder(
      cubit: BlocProvider.of<TemaBloc>(context),
        builder: (context,TemaState state)
        {
          return  Scaffold(
            floatingActionButton: FloatingActionButton(

              backgroundColor: (state as UygulamaTemasi).renk,
              onPressed: () async {
                kullanicininsectigisehir = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SehirSecWidget(),
                  ),
                );
                debugPrint("seçilen sehir:" + kullanicininsectigisehir);
                if(kullanicininsectigisehir!=null){
                  _weatherbloc.add(FetchWeatherEvent(sehirAdi: kullanicininsectigisehir));
                }
              },
              child: Icon(Icons.search),
            ),
            backgroundColor: Colors.black38,
            body: Center(
              child: BlocBuilder(
                cubit: _weatherbloc,
                builder: (BuildContext context, WeatherState state)  {
                  if(state is WeatherInitial){
                    return Center(child: Text("sağ alttaki butonu kullanarak sehir girin",style: TextStyle(color: Colors.white),),);
                  }
                  if(state is WeatherLoadingstate){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  if(state is WeatherLoadedstate){
                    final getilienweather=state.weather;
                    final havaDurumukisaltma=getilienweather.consolidatedWeather[0].weatherStateAbbr;

                    kullanicininsectigisehir=getilienweather.title;
                    final _temabloc=BlocProvider.of<TemaBloc>(context);
                    _temabloc.add(TemadegistirEvent(havadurumukisaltmasi: havaDurumukisaltma));

                    _refreshCompleter.complete();
                    _refreshCompleter=Completer();

                    return BlocBuilder(
                      cubit: BlocProvider.of<TemaBloc>(context),
                      builder: (context,TemaState temastate)=>
                          GecislirenkContainer(
                            renk: (temastate as UygulamaTemasi).renk ,
                            child: RefreshIndicator(
                              onRefresh: (){
                                _weatherbloc.add(RefleshFetchWeatherEvent(sehirAdi: kullanicininsectigisehir));
                                return _refreshCompleter.future;
                              },
                              child: ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: 5,
                                itemBuilder: (context,int index){
                                  return Column(
                                    children:[

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                            child: LocationWidget(
                                              secilenSehir: getilienweather.title,
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(child: SonguncellenenWidget(ide: index,)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(child: HavadurumuresimWidget(ide: index,)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Center(child: MaxminsicaklikWidget(ide: index,)),
                                      ),
                                      /*
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: LocationWidget(
                                  secilenSehir: getilienweather.title,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: SonguncellenenWidget(ide: 1,)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: HavadurumuresimWidget(ide:1)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(child: MaxminsicaklikWidget(ide: 1,)),
                          ),
                          */

                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                    );

                  }
                  if(state is Weathererrorstate){
                    return Center(child: Text("Hata Oluştu !!! \n Kullandığım api türkiyeden sadece 3 şehrin hava durumunu gösteriyo Ankara,İstanbul ve İzmir \n Ama diğer Ülkelerdeki şehirlerin hava durumlarına bakabilirsiniz \n ÖRN:new york,rio ,berlin,tokyo vb...\n api nin hangi şehirlerin hava durumunu gösterdiğini görmek için \n https://www.metaweather.com/map/"
                    ,style: TextStyle(color: Colors.white),),);
                  }


                },
              ),
            ),
          );
        }

    );
  }
}
