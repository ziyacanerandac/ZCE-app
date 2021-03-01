import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as mathematic;
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';

class mailguncelle extends StatefulWidget {
  @override
  _mailguncelleState createState() => _mailguncelleState();
}

class _mailguncelleState extends State<mailguncelle> {
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
        errorColor: Colors.orangeAccent,
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
            "Mail Güncelle",
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
                    hintText: "Yeni Email adresiniz",
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
                    disabledColor: Colors.cyan,
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
  String _mailkontol(String mail) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(mail))
      return 'Gecersiz mail';
    else
      return null;
  }


  void _girisbilgilerionayla()  {

    if(formkey.currentState.validate())
    {
      formkey.currentState.save();
      debugPrint("girilen sifre:$_emailadress");
      _emailiguncelle();

    }
    else{
      setState(() {
        otomatikkontrol=true;
      });
    }
  }



  void _emailiguncelle() async{
    if( await _auth.currentUser != null){

      await _auth.currentUser.updateEmail(_emailadress);
      setState(() {
        mesaj+="\n Email güncellendi";
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

                content: Text("Email güncellendi "),
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
    }
    else{
      setState(() {
        mesaj+="\n email güncellemek için önce oturum açın";
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

                content: Text(" email güncellemek için önce oturum açın "),
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
    }
  }



}

Color _rastgeleRenk() {
  return Color.fromARGB(
      mathematic.Random().nextInt(255),
      mathematic.Random().nextInt(255),
      mathematic.Random().nextInt(255),
      mathematic.Random().nextInt(255));
}
