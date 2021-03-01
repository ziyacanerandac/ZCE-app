import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as mathematic;
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';

class sifremiunuttum extends StatefulWidget {
  @override
  _sifremiunuttumState createState() => _sifremiunuttumState();
}

class _sifremiunuttumState extends State<sifremiunuttum> {
  String  _emailadress;
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
        errorColor: Colors.orange,
        hintColor: Colors.orangeAccent,
      ),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {

            _girisbilgilerionayla();
          },
          child: Icon(Icons.send),
        ),
        appBar: AppBar(
          title: Text(
            "Sifremiunuttum",
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
                        color: Colors.cyan,
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

                RaisedButton.icon(
                    icon: Icon(Icons.send),
                    label: Text("Tamam"),
                    color: Colors.cyan,
                    disabledColor: Colors.red,
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
      debugPrint("girilen mail:$_emailadress");
      _sifremiunuttum();

    }
    else{
      setState(() {
        otomatikkontrol=true;
      });
    }
  }
  void _sifremiunuttum() {
    String mail=_emailadress;
    _auth.sendPasswordResetEmail(email:mail).then((value){
      setState(() {
        mesaj+="\nsıfırlama maili gönderildi";
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
                    Text("BAŞARILI"),

                  ],
                ),

                content: Text("Yeni paralonız mailinize gönderilmiştir "),
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
      });

    } ).catchError((hata){
      setState(() {
        mesaj+="\nsifremi unuttum mailinde hata $hata";
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

                content: Text(" yeni şifreniz mailinize gönderilemedi lütfen tekrar deneyiniz!!! "),
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
      });
    });
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




}

