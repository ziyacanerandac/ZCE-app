import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zce/mainhesaplama.dart';
import 'dart:math' as mathematic;

import 'package:zce/screen/Mainpage.dart';

import 'package:zce/screen/mail_guncelle.dart';
import 'package:zce/screen/Burcmain.dart';
import 'package:zce/screen/sifre_guncelle.dart';
import 'package:zce/views/home.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;
class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  final GoogleSignIn _googleauth=GoogleSignIn(scopes: ['email']);
  @override
  Widget build(BuildContext context) {
    return  Drawer(

      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("ZCE APP"),
                  Image.asset("assets/images/zca1.png", width: 150, height: 100, fit: BoxFit.contain),

                  Text(_auth.currentUser.email),
                ],
              ),
            ),

          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text("ANA SAYFA"),
                  trailing: Icon(Icons.chevron_right),
                  onTap: (){
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Mainpage()));
                    });
                  },
                ),
                ListTile(
                  leading: Icon(Icons.language),
                  title: Text("BURÇ REHBERİ"),
                  trailing: Icon(Icons.chevron_right),
                  onTap: (){
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyApps()));
                    });
                  },
                ),
                ListTile(
                  leading: Icon(Icons.calculate),
                  title: Text("BURÇ HESAPLAMA"),
                  trailing: Icon(Icons.chevron_right),
                  onTap: (){
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

                  },
                ),
                ListTile(
                  leading: Icon(Icons.add),
                  title: Text("ORTALAMA HESAPLAMA"),
                  trailing: Icon(Icons.chevron_right),
                  onTap: (){
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyApp()));
                    });
                  },
                ),
                InkWell(
                  splashColor: _rastgeleRenk(),
                  onTap: (){
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Home()));
                    });
                  },
                  child: ListTile(
                    leading: Icon(Icons.recent_actors),
                    title: Text("GÜNCEL HABERLER"),
                    trailing: Icon(Icons.chevron_right),
                    onTap: (){
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Home()));
                      });
                    },
                  ),
                ),

                Divider(),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("E-MAİLİ GÜNCELLE"),
                  trailing: Icon(Icons.chevron_right),
                  onTap: (){
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  mailguncelle()));
                    });
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("SİFREYİ GÜNCELLE"),
                  trailing: Icon(Icons.chevron_right),
                  onTap: (){
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              sifremiguncelle()));
                    });
                  },
                ),
                AboutListTile(
                  applicationName: "ZCE APP ",
                  applicationIcon: Icon(Icons.account_circle),
                  applicationVersion: "1.0.1",
                  child: Text("ABOUT APP"),
                  applicationLegalese: null,
                  icon: Icon(Icons.help_outline),

                  aboutBoxChildren: <Widget>[
                    Text("DESTEK VE İLETİŞİM: \n"

                        "ziyacanerandac@gmail.com\n"

                    ),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
Color _rastgeleRenk() {
  return Color.fromARGB(
      mathematic.Random().nextInt(255),
      mathematic.Random().nextInt(255),
      mathematic.Random().nextInt(255),
      mathematic.Random().nextInt(255));
}
