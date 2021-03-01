import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zce/mainhesaplama.dart';

import 'dart:math' as mathematic;

import 'package:zce/screen/Drawer_menu.dart';
import 'package:zce/screen/Login.dart';
import 'package:zce/screen/Rastgelerenk.dart';

import 'package:zce/screen/Burcmain.dart';
import 'package:zce/views/home.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zce/havadurumu/loacator.dart';
import 'package:zce/havadurumu/weather/tema/tema_bloc.dart';
import 'package:zce/havadurumu/weather/weather_bloc.dart';
import 'package:zce/havadurumu/widget/weather_app.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;
class Mainpage extends StatefulWidget {
  @override

  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  final GoogleSignIn _googleauth=GoogleSignIn(scopes: ['email']);
  String mesaj="";
  int secilenitem = 0;
  List<Widget> tumsayfalar;
  havadurumu pageana;
  yonlendir pageyonlendir;
  habersayfasi pagehava;
  var keyanasayfa = PageStorageKey("key_ana_sayfa");
  var keyyonlendir = PageStorageKey("key_yonleri_sayfa");
  var keyhava = PageStorageKey("key_hava_sayfa");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageana = havadurumu(keyanasayfa);
    pageyonlendir = yonlendir(keyyonlendir);
    pagehava = habersayfasi(keyhava);
    tumsayfalar = [pageana, pageyonlendir, pagehava];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
            "ZCE APP",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.cyanAccent),
          ),
            IconButton(icon: Icon(Icons.close), onPressed: (){
              _cikisyap();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Stepperwidget()),
                    (Route<dynamic> route) => false,
              );
              /* Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Stepperwidget()),
              );
    */
            })

          ],

        ),
      ),
      body: secilenitem <= tumsayfalar.length - 1
          ? tumsayfalar[secilenitem]
          : tumsayfalar[0],
      bottomNavigationBar: BottomNavMenu(),
    );
  }
  void _cikisyap()async {
    if(await _auth.currentUser!=null){
      _auth.signOut().then((value) {
        _googleauth.signOut();
        setState(() {
          mesaj+="\nkullanıcı çıkış yaptı";
        });}).catchError((hata){
        setState(() {
          mesaj+="\nçıkış yaparken hata oluştu $hata";
        });
      });
    }

    else{
      mesaj +="\noturum açmış kullanıcı yok";
    }
    setState(() {

    });
  }

  BottomNavigationBar BottomNavMenu() {
    return BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            backgroundColor: Colors.cyan,
            activeIcon: Icon(Icons.cloud_queue_outlined),
            title: Text("Hava Durumu"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            backgroundColor: Colors.cyan,
            title: Text("Diğer"),
            activeIcon: Icon(Icons.add_circle_outline),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            backgroundColor: Colors.cyan,
            title: Text("Haber"),
            activeIcon: Icon(Icons.article_outlined),

          ),
        ],
        // type: BottomNavigationBarType.fixed,), baya önemli buda 3 ten fazla ise sığdırmaya yarıyor
        type: BottomNavigationBarType.shifting,
        currentIndex: secilenitem,
        onTap: (index) {
          setState(() {
            secilenitem = index;
          });
        });
  }
}

class havadurumu extends StatefulWidget {
  // This widget is the root of your application.
  havadurumu(Key k) : super(key: k);
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
            title: 'ZCE APP',
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


class yonlendir extends StatefulWidget {
  yonlendir(Key k) : super(key: k);

  @override
  yonlendir_State createState() => yonlendir_State();
}

class yonlendir_State extends State<yonlendir> {
  List<Veri> tumveri;
int state=1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tumveri = [
      Veri(
          "Burç Rehberi",
          "Açıklama:Burç Rehberi bugün sizin için neler söylüyor? Aşk, İş, Para ve Kariyer durumunuz ile ilgili koç burcu, boğa burcu, ikizler burcu, yengeç burcu, aslan burcu, başak burcu, terazi burcu, akrep burcu, yay burcu, oğlak burcu, kova burcu ve balık burcu günlük yorumları",
          false),
      Veri("Burç Hesaplama", "Açıklama:", false),
      Veri("Not Ortalaması Hesaplama", "Açıklama:", false),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ExpansionTile(
          key: PageStorageKey("$index"),
          initiallyExpanded: tumveri[index].expanded,
          title: Text(tumveri[index].baslik),
          children: <Widget>[
            Container(

              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/mixed.jpg"),fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(6),
               // color: Colors.black,
              ),
              height: 300,
              width: double.infinity,
              child: RaisedButton(child: Text("enter"),color: rastgeleRenk(), onPressed: () {
                setState(() {

                  if(index==0)
                  {

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApps()));
                  }
                      else if(index==1) {
                    String burc;
                    DateTime suan = DateTime.now();
                    DateTime yuzyilloncesi = DateTime(suan.year - 100, suan.month);
                    DateTime biGunSonrasi = DateTime(suan.year, suan.month, suan.day + 1);

                    showDatePicker(
                        context: context,
                        initialDate: suan,
                        firstDate: yuzyilloncesi,
                        lastDate: biGunSonrasi)
                        .then(
                          (secilentarih) {
                        if (secilentarih.month == 1) {
                          if (secilentarih.day <= 19) {
                            debugPrint("oğlak");
                            burc = "oğlak";
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Image.asset("images/oglak10.png",
                                          width: 50, height: 50, fit: BoxFit.contain,),
                                        Text(
                                        "BURCUNUZ:  ",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Elyazisi",
                                          fontWeight: FontWeight.w600,

                                        ),

                                      ),
                                        Text(
                                            burc ,
                                          style: TextStyle(
                                            color: Colors.cyan,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,

                                          ),

                                        ),
                                      ],

                                    ),

                                    //--------------------------------
                                    content: RaisedButton(
                                        child: Text("Tamam"),
                                        onPressed: () {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Mainpage()));
                                          });
                                        }),
                                  );
                                });
                          } else if (secilentarih.day > 19) {
                            debugPrint("kova");
                            burc = "kova";
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Image.asset("images/kova11.png",
                                          width: 50, height: 50, fit: BoxFit.contain,),
                                        Text(
                                          "BURCUNUZ:  ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.w600,

                                          ),

                                        ),
                                        Text(
                                          burc ,
                                          style: TextStyle(
                                            color: Colors.cyan,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,

                                          ),

                                        ),],

                                    ),

                                    //--------------------------------
                                    content: RaisedButton(
                                        child: Text("Tamam"),
                                        onPressed: () {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Mainpage()));
                                          });
                                        }),
                                  );
                                });
                          }
                        } else if (secilentarih.month == 2) {
                          if (secilentarih.day <= 18) {
                            debugPrint("kova");
                            burc = "kova";
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Image.asset("images/kova11.png",
                                          width: 50, height: 50, fit: BoxFit.contain,),
                                        Text(
                                          "BURCUNUZ:  ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.w600,

                                          ),

                                        ),
                                        Text(
                                          burc ,
                                          style: TextStyle(
                                            color: Colors.cyan,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,

                                          ),

                                        ),],

                                    ),

                                    //--------------------------------
                                    content: RaisedButton(
                                        child: Text("Tamam"),
                                        onPressed: () {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Mainpage()));
                                          });
                                        }),
                                  );
                                });
                          } else if (secilentarih.day > 18) {
                            debugPrint("balık");
                            burc = "balık";
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Image.asset("images/balik12.png",
                                          width: 50, height: 50, fit: BoxFit.contain,),
                                        Text(
                                          "BURCUNUZ:  ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.w600,

                                          ),

                                        ),
                                        Text(
                                          burc ,
                                          style: TextStyle(
                                            color: Colors.cyan,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,

                                          ),

                                        ),],

                                    ),

                                    //--------------------------------
                                    content: RaisedButton(
                                        child: Text("Tamam"),
                                        onPressed: () {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Mainpage()));
                                          });
                                        }),
                                  );
                                });

                          }
                        } else if (secilentarih.month == 3) {
                          if (secilentarih.day <= 19) {
                            debugPrint("balık");
                            burc = "balık";
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Image.asset("images/kova11.png",
                                          width: 50, height: 50, fit: BoxFit.contain,),
                                        Text(
                                          "BURCUNUZ:  ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.w600,

                                          ),

                                        ),
                                        Text(
                                          burc ,
                                          style: TextStyle(
                                            color: Colors.cyan,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,

                                          ),

                                        ),],

                                    ),

                                    //--------------------------------
                                    content: RaisedButton(
                                        child: Text("Tamam"),
                                        onPressed: () {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Mainpage()));
                                          });
                                        }),
                                  );
                                });
                          } else if (secilentarih.day > 19) {
                            debugPrint("koç");
                            burc = "koç";
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Image.asset("images/koc1.png",
                                          width: 50, height: 50, fit: BoxFit.contain,),
                                        Text(
                                          "BURCUNUZ:  ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.w600,

                                          ),

                                        ),
                                        Text(
                                          burc ,
                                          style: TextStyle(
                                            color: Colors.cyan,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,

                                          ),

                                        ),],

                                    ),

                                    //--------------------------------
                                    content: RaisedButton(
                                        child: Text("Tamam"),
                                        onPressed: () {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Mainpage()));
                                          });
                                        }),
                                  );
                                });
                          }
                        } else if (secilentarih.month == 4) {
                          if (secilentarih.day <= 19) {
                            debugPrint("koç");
                            burc = "koç";
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Image.asset("images/koc1.png",
                                          width: 50, height: 50, fit: BoxFit.contain,),
                                        Text(
                                          "BURCUNUZ:  ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.w600,

                                          ),

                                        ),
                                        Text(
                                          burc ,
                                          style: TextStyle(
                                            color: Colors.cyan,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,

                                          ),

                                        ),],

                                    ),

                                    //--------------------------------
                                    content: RaisedButton(
                                        child: Text("Tamam"),
                                        onPressed: () {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Mainpage()));
                                          });
                                        }),
                                  );
                                });
                          } else if (secilentarih.day > 19) {
                            debugPrint("boğa");
                            burc = "boğa";
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Image.asset("images/boga2.png",
                                          width: 50, height: 50, fit: BoxFit.contain,),
                                        Text(
                                          "BURCUNUZ:  ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.w600,

                                          ),

                                        ),
                                        Text(
                                          burc ,
                                          style: TextStyle(
                                            color: Colors.cyan,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,

                                          ),

                                        ),],

                                    ),

                                    //--------------------------------
                                    content: RaisedButton(
                                        child: Text("Tamam"),
                                        onPressed: () {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Mainpage()));
                                          });
                                        }),
                                  );
                                });
                          }
                        } else if (secilentarih.month == 5) {
                          if (secilentarih.day <= 20) {
                            debugPrint("boğa");
                            burc = "boğa";
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Image.asset("images/boga2.png",
                                          width: 50, height: 50, fit: BoxFit.contain,),
                                        Text(
                                          "BURCUNUZ:  ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.w600,

                                          ),

                                        ),
                                        Text(
                                          burc ,
                                          style: TextStyle(
                                            color: Colors.cyan,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,

                                          ),

                                        ),],

                                    ),

                                    //--------------------------------
                                    content: RaisedButton(
                                        child: Text("Tamam"),
                                        onPressed: () {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Mainpage()));
                                          });
                                        }),
                                  );
                                });
                          } else if (secilentarih.day > 20) {
                            debugPrint("ikizler");
                            burc = "ikizler";
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Image.asset("images/ikizler3.png",
                                          width: 50, height: 50, fit: BoxFit.contain,),
                                        Text(
                                          "BURCUNUZ:  ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.w600,

                                          ),

                                        ),
                                        Text(
                                          burc ,
                                          style: TextStyle(
                                            color: Colors.cyan,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,

                                          ),

                                        ),],

                                    ),

                                    //--------------------------------
                                    content: RaisedButton(
                                        child: Text("Tamam"),
                                        onPressed: () {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Mainpage()));
                                          });
                                        }),
                                  );
                                });
                          }
                        } else if (secilentarih.month == 6) {
                          if (secilentarih.day <= 21) {
                            debugPrint("ikizler");
                            burc = "ikizler";
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Image.asset("images/ikizler3.png",
                                          width: 50, height: 50, fit: BoxFit.contain,),
                                        Text(
                                          "BURCUNUZ:  ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.w600,

                                          ),

                                        ),
                                        Text(
                                          burc ,
                                          style: TextStyle(
                                            color: Colors.cyan,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,

                                          ),

                                        ),],

                                    ),

                                    //--------------------------------
                                    content: RaisedButton(
                                        child: Text("Tamam"),
                                        onPressed: () {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Mainpage()));
                                          });
                                        }),
                                  );
                                });
                          } else if (secilentarih.day > 21) {
                            debugPrint("yengeç");
                            burc = "yengeç";
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Image.asset("images/yengec4.png",
                                          width: 50, height: 50, fit: BoxFit.contain,),
                                        Text(
                                          "BURCUNUZ:  ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.w600,

                                          ),

                                        ),
                                        Text(
                                          burc ,
                                          style: TextStyle(
                                            color: Colors.cyan,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,

                                          ),

                                        ),],

                                    ),

                                    //--------------------------------
                                    content: RaisedButton(
                                        child: Text("Tamam"),
                                        onPressed: () {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Mainpage()));
                                          });
                                        }),
                                  );
                                });
                          }
                        } else if (secilentarih.month == 7) {
                          if (secilentarih.day <= 22) {
                            debugPrint("yengeç");
                            burc = "yengeç";
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Image.asset("images/ikizler3.png",
                                          width: 50, height: 50, fit: BoxFit.contain,),
                                        Text(
                                          "BURCUNUZ:  ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.w600,

                                          ),

                                        ),
                                        Text(
                                          burc ,
                                          style: TextStyle(
                                            color: Colors.cyan,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,

                                          ),

                                        ),],

                                    ),

                                    //--------------------------------
                                    content: RaisedButton(
                                        child: Text("Tamam"),
                                        onPressed: () {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Mainpage()));
                                          });
                                        }),
                                  );
                                });
                          } else if (secilentarih.day > 22) {
                            debugPrint("aslan");
                            burc = "aslan";
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Image.asset("images/aslan5.png",
                                          width: 50, height: 50, fit: BoxFit.contain,),
                                        Text(
                                          "BURCUNUZ:  ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.w600,

                                          ),

                                        ),
                                        Text(
                                          burc ,
                                          style: TextStyle(
                                            color: Colors.cyan,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,

                                          ),

                                        ),],

                                    ),

                                    //--------------------------------
                                    content: RaisedButton(
                                        child: Text("Tamam"),
                                        onPressed: () {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Mainpage()));
                                          });
                                        }),
                                  );
                                });
                          }
                        } else if (secilentarih.month == 8) {
                          if (secilentarih.day <= 22) {
                            debugPrint("aslan");
                            burc = "aslan";
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Image.asset("images/aslan5.png",
                                          width: 50, height: 50, fit: BoxFit.contain,),
                                        Text(
                                          "BURCUNUZ:  ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.w600,

                                          ),

                                        ),
                                        Text(
                                          burc ,
                                          style: TextStyle(
                                            color: Colors.cyan,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,

                                          ),

                                        ),],

                                    ),

                                    //--------------------------------
                                    content: RaisedButton(
                                        child: Text("Tamam"),
                                        onPressed: () {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Mainpage()));
                                          });
                                        }),
                                  );
                                });
                          } else if (secilentarih.day > 22) {
                            debugPrint("başak");
                            burc = "başak";
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Image.asset("images/basak6.png",
                                          width: 50, height: 50, fit: BoxFit.contain,),
                                        Text(
                                          "BURCUNUZ:  ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.w600,

                                          ),

                                        ),
                                        Text(
                                          burc ,
                                          style: TextStyle(
                                            color: Colors.cyan,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,

                                          ),

                                        ),],

                                    ),

                                    //--------------------------------
                                    content: RaisedButton(
                                        child: Text("Tamam"),
                                        onPressed: () {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Mainpage()));
                                          });
                                        }),
                                  );
                                });
                          }
                        } else if (secilentarih.month == 9) {
                          if (secilentarih.day <= 22) {
                            debugPrint("başak");
                            burc = "başak";
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Image.asset("images/basak6.png",
                                          width: 50, height: 50, fit: BoxFit.contain,),
                                        Text(
                                          "BURCUNUZ:  ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.w600,

                                          ),

                                        ),
                                        Text(
                                          burc ,
                                          style: TextStyle(
                                            color: Colors.cyan,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,

                                          ),

                                        ),],

                                    ),

                                    //--------------------------------
                                    content: RaisedButton(
                                        child: Text("Tamam"),
                                        onPressed: () {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Mainpage()));
                                          });
                                        }),
                                  );
                                });
                          } else if (secilentarih.day > 22) {
                            debugPrint("terazi");
                            burc = "terazi";
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Image.asset("images/terazi7.png",
                                          width: 50, height: 50, fit: BoxFit.contain,),
                                        Text(
                                          "BURCUNUZ:  ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.w600,

                                          ),

                                        ),
                                        Text(
                                          burc ,
                                          style: TextStyle(
                                            color: Colors.cyan,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,

                                          ),

                                        ),],

                                    ),

                                    //--------------------------------
                                    content: RaisedButton(
                                        child: Text("Tamam"),
                                        onPressed: () {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Mainpage()));
                                          });
                                        }),
                                  );
                                });
                          }
                        } else if (secilentarih.month == 10) {
                          if (secilentarih.day <= 22) {

                            debugPrint("terazi");
                            burc = "terazi";
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Image.asset("images/terazi7.png",
                                          width: 50, height: 50, fit: BoxFit.contain,),
                                        Text(
                                          "BURCUNUZ:  ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.w600,

                                          ),

                                        ),
                                        Text(
                                          burc ,
                                          style: TextStyle(
                                            color: Colors.cyan,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,

                                          ),

                                        ),],

                                    ),

                                    //--------------------------------
                                    content: RaisedButton(
                                        child: Text("Tamam"),
                                        onPressed: () {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Mainpage()));
                                          });
                                        }),
                                  );
                                });
                          } else if (secilentarih.day > 22) {
                            debugPrint("akrep");
                            burc = "akrep";
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Image.asset("images/akrep8.png",
                                          width: 50, height: 50, fit: BoxFit.contain,),
                                        Text(
                                          "BURCUNUZ:  ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.w600,

                                          ),

                                        ),
                                        Text(
                                          burc ,
                                          style: TextStyle(
                                            color: Colors.cyan,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,

                                          ),

                                        ),],

                                    ),

                                    //--------------------------------
                                    content: RaisedButton(
                                        child: Text("Tamam"),
                                        onPressed: () {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Mainpage()));
                                          });
                                        }),
                                  );
                                });
                          }
                        } else if (secilentarih.month == 11) {
                          if (secilentarih.day <= 21) {
                            debugPrint("akrep");
                            burc = "akrep";
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Image.asset("images/akrep8.png",
                                          width: 50, height: 50, fit: BoxFit.contain,),
                                        Text(
                                          "BURCUNUZ:  ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.w600,

                                          ),

                                        ),
                                        Text(
                                          burc ,
                                          style: TextStyle(
                                            color: Colors.cyan,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,

                                          ),

                                        ),],

                                    ),

                                    //--------------------------------
                                    content: RaisedButton(
                                        child: Text("Tamam"),
                                        onPressed: () {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Mainpage()));
                                          });
                                        }),
                                  );
                                });
                          } else if (secilentarih.day > 21) {
                            debugPrint("yay");
                            burc = "yay";
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Image.asset("images/yay9.png",
                                          width: 50, height: 50, fit: BoxFit.contain,),
                                        Text(
                                          "BURCUNUZ:  ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.w600,

                                          ),

                                        ),
                                        Text(
                                          burc ,
                                          style: TextStyle(
                                            color: Colors.cyan,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,

                                          ),

                                        ),],

                                    ),

                                    //--------------------------------
                                    content: RaisedButton(
                                        child: Text("Tamam"),
                                        onPressed: () {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Mainpage()));
                                          });
                                        }),
                                  );
                                });
                          }
                        } else if (secilentarih.month == 12) {
                          if (secilentarih.day <= 21) {
                            debugPrint("yay");
                            burc = "yay";
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Image.asset("images/yay9.png",
                                          width: 50, height: 50, fit: BoxFit.contain,),
                                        Text(
                                          "BURCUNUZ:  ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.w600,

                                          ),

                                        ),
                                        Text(
                                          burc ,
                                          style: TextStyle(
                                            color: Colors.cyan,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,

                                          ),

                                        ),],

                                    ),

                                    //--------------------------------
                                    content: RaisedButton(
                                        child: Text("Tamam"),
                                        onPressed: () {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Mainpage()));
                                          });
                                        }),
                                  );
                                });
                          } else if (secilentarih.day > 21) {
                            debugPrint("oğlak");
                            burc = "oğlak";
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Image.asset("images/oglak10.png",
                                          width: 50, height: 50, fit: BoxFit.contain,),
                                        Text(
                                          "BURCUNUZ:  ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.w600,

                                          ),

                                        ),
                                        Text(
                                          burc ,
                                          style: TextStyle(
                                            color: Colors.cyan,
                                            fontFamily: "Elyazisi",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,

                                          ),

                                        ),],

                                    ),

                                    //--------------------------------
                                    content: RaisedButton(
                                        child: Text("Tamam"),
                                        onPressed: () {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Mainpage()));
                                          });
                                        }),
                                  );
                                });
                          }
                        };
                      },
                    );

                   // Navigator.push(context, MaterialPageRoute(builder: (context) => Tarihsaatstate()));

                  }
                      else if(index==2){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp()));
                  }

                });
              }),
            ),
          ],
        );
      },
      itemCount: tumveri.length,
    );
  }
}

class habersayfasi extends StatefulWidget {
  habersayfasi(Key k) : super(key: k);

  @override
  _habersayfasiState createState() => _habersayfasiState();
}

class _habersayfasiState extends State<habersayfasi> {



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: (){

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Mainpage()),
                (Route<dynamic> route) => false,
          );
        },
        child: Home());
  }
}

class Veri {
  String baslik;

  String icerik;
  bool expanded;

  Veri(this.baslik, this.icerik, this.expanded);
}
