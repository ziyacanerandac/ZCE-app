import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as mathematic;
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';

class formvetextformfield extends StatefulWidget {
  @override
  _formvetextformfieldState createState() => _formvetextformfieldState();
}

class _formvetextformfieldState extends State<formvetextformfield> {
  String _adsoyad, _sifre, _emailadress;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleauth=GoogleSignIn(scopes: ['email']);
  String mesaj="";
  final formkey=GlobalKey<FormState>();
  bool otomatikkontrol=false;
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth.authStateChanges().listen((user) {
      setState(() {
        if(user!=null)
        {
          mesaj +="\nListener tetiklendi kullanıcı oturum açtı";
        }
        else{
          mesaj +="\nListener tetiklendi kullanıcı oturum kapattı";
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        errorColor: Colors.orangeAccent,
        hintColor: Colors.orangeAccent,
      ),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {

            _girisbilgilerionayla();
          },
          child: Icon(Icons.save),
        ),
        appBar: AppBar(
          title: Text(
            "Kullanıcı Oluştur",
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: formkey,
            autovalidate: otomatikkontrol,
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_circle),
                    hintText: "Username",
                    labelText: "Username",
                   // focusColor: Colors.orangeAccent,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.cyan,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.cyan,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                  //initialValue: ziya,
                  validator: _namekontol,
                  onSaved:(deger)=>_adsoyad=deger ,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: "Email adresiniz",
                    labelText: "Email",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.cyan,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:  Colors.cyan,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                  validator: _mailkontol,
                  onSaved:(deger)=>_emailadress=deger ,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: " en az 1 büyükharf, 1 küçükharf, 1 sayi",
                    labelText: "Sifre",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:  Colors.cyan,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:  Colors.cyan,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                  validator: _validatePassword,
                  onSaved:(deger)=>_sifre=deger ,
                ),
                RaisedButton.icon(
                    icon: Icon(Icons.save),
                    label: Text("KAYDET"),
                    color:  Colors.cyan,
                    disabledColor:  Colors.cyan,
                    onPressed: () {
                      _girisbilgilerionayla();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

void _girisbilgilerionayla()  {

    if(formkey.currentState.validate())
    {
      formkey.currentState.save();
      debugPrint("girilen ad ve soyad:$_adsoyad,girilen mail:$_emailadress,girilen sifre:$_sifre");
     _emailvesifrelogin();

    }
    else{
      setState(() {
        otomatikkontrol=true;
      });
    }
  }

  String _mailkontol(String mail) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(mail))
      return 'Gecersiz mail';
    else
      return null;
  }
  String _validatePassword(String sifre) {
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])';
    RegExp regex = new RegExp(pattern);
    print(sifre);
    if (sifre.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(sifre))
        return 'Enter valid password';
      else
        return null;
    }
  }
  String _namekontol(String name)
  {
    if (name.length < 3) {
      return "Lütfen en az 3 karakter giriniz";
    } else {
      return null;
    }
  }

void _emailvesifrelogin() async {
    String mail = _emailadress;
    String sifre = _sifre;

    var authResult = await _auth
        .createUserWithEmailAndPassword(email: mail, password: sifre)
        .catchError((e) {
      showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title:
              Row(
                children: [
                  Image.network('https://img2.pngindir.com/20180314/dre/kisspng-error-message-icon-warning-icons-5aa8e8c4d021e4.3508332815210190768525.jpg',
                    width: 50, height: 50, fit: BoxFit.contain,),
                  SizedBox(width: 50),
                  Text("BAŞARISIZ"),

                ],
              ),

              content: Text("BU HESAP DAHA ÖNCEDEN OLUŞTURULMUŞTUR LÜTFEN FARKLI Bİ HESAP İLE TEKRAR DENEYİN !!! "),
              actions: <Widget>[
                TextButton(
                  child: Text('Tamam'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
        debugPrint("hataaa :" + e.toString());


        });
    var firebaseUser1 = authResult.user;
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:
            Row(
              children: [
                Image.network('https://img2.pngindir.com/20180727/boa/kisspng-social-media-check-mark-symbol-computer-icons-user-blue-tic-5b5b96fb7c42b0.654125411532729083509.jpg',
                  width: 50, height: 50, fit: BoxFit.contain,),
                SizedBox(width: 50),
                Text("   BAŞARILI"),

              ],
            ),

            content: Text("HESABINIZ BAŞARILI Bİ ŞEKİLDE OLUŞTURULMUŞTUR LÜTFEN MAİLİNİZDEN ONAY KODUNU ONAYLAYINIZ!! !!! "),
            actions: <Widget>[
              TextButton(
                child: Text('Tamam'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });

    if (firebaseUser1 != null) {

      firebaseUser1.sendEmailVerification().then((value){
        _auth.signOut();
      }).catchError((e)=>debugPrint("MAİL GÖNDERİRKEN HATA $e"));
      setState(() {
        mesaj= " uid:${firebaseUser1.uid}\nmail:${firebaseUser1.email}\nmailonaylımı:${firebaseUser1.emailVerified}\n E mail gönderildi lütfen onaylayın !!!";



      });
      debugPrint(

          " uid:${firebaseUser1.uid},mail:${firebaseUser1.email},mailonaylımı:${firebaseUser1.emailVerified}");



    }else{

      setState(() {

        mesaj="bu mail zaten kullanımda";


      });

    }
  }



}

