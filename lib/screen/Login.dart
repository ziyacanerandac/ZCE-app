import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zce/screen/Kullanici_olustur.dart';

import 'dart:math' as mathematic;

import 'package:zce/screen/Mainpage.dart';
import 'package:zce/screen/sifremiunuttum.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;
class Stepperwidget extends StatefulWidget {
  @override
  _StepperwidgetState createState() => _StepperwidgetState();
}

class _StepperwidgetState extends State<Stepperwidget> {

  final GoogleSignIn _googleauth=GoogleSignIn(scopes: ['email']);
  String mesaj="";

  int _aktifstep = 0;
  String isim, mail, sifre;
  List<Step> tumstate;
  bool hata = false;
  var key0 = GlobalKey<FormFieldState>();
  var key1 = GlobalKey<FormFieldState>();
  var key2 = GlobalKey<FormFieldState>();

  @override
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
    tumstate = _tumstepler();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset("assets/images/zca1.png",
              width: 50, height: 50, fit: BoxFit.contain,),
            Text("      ZCE APP GİRİŞ EKRANI"),
          ],
          ),

        iconTheme: IconThemeData.fallback(),
        primary: true,
        backgroundColor: Colors.cyan[700],
        excludeHeaderSemantics: true,
        elevation: 12,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
           Stepper(
            steps: tumstate,
            currentStep: _aktifstep,
            onStepTapped: (tiklanilandeger) {
              setState(() {
                _aktifstep = tiklanilandeger;
              });
            },
            onStepContinue: () {
              setState(() {
                _ileributonkontrol();
              });
            },
            onStepCancel: () {
              setState(() {
                if (_aktifstep > 0) {
                  _aktifstep--;
                } else {
                  setState(() {
                    _aktifstep = 0;
                  });
                }
              });
            },
          ),
            Divider(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SignInButtonBuilder(
                  text: ' E-mail ile kayıt ol',
                  icon: Icons.email,
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => formvetextformfield()),
                    );
                  },
                  backgroundColor: Colors.blueGrey[700],
                  width: 220.0,
                ),

                SizedBox(),
                SignInButton(
                  Buttons.Google,
                  onPressed: () {
                    _googlegiris();
                  },
                ),
                SizedBox(),
                SignInButtonBuilder(
                  text: ' Sifremi unuttum',
                  icon: Icons.vpn_key,
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => sifremiunuttum()),
                    );
                  },
                  backgroundColor: Colors.orangeAccent[700],
                  width: 220.0,
                ),





              ],
            ),

            

          ],
        ),
      ),
    );
  }

  List<Step> _tumstepler() {
    List<Step> stepler = [
      Step(
        title: Text("Name"),
        subtitle: Text("Enter your username"),
        state: Statleriayarla(0),
        isActive: true,
        content: TextFormField(
          keyboardType: TextInputType.text,
          key: key0,
          decoration: InputDecoration(
            icon: Icon(Icons.account_circle),
            labelText: "Username",
            hintText: "Exapmle",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            enabled: true,
            alignLabelWithHint: true,
            contentPadding: EdgeInsets.all(11),
          ),
          validator: (girilendeg) {
            if (girilendeg.length < 3) {
              return "invalid username";
            } else {
              return null;
            }
          },
          onSaved: (girilendeg) {
            isim = girilendeg;
          },
        ),
      ),
      Step(
        title: Text("E-mail:"),
        subtitle: Text("Enter your mail"),
        state: Statleriayarla(1),
        isActive: true,
        content: TextFormField(
          keyboardType: TextInputType.emailAddress,
          key: key1,
          decoration: InputDecoration(
            icon: Icon(Icons.mail),
            labelText: "E-mail",
            hintText: "example@hotmail.com",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            enabled: true,
            alignLabelWithHint: true,
            contentPadding: EdgeInsets.all(11),
          ),
          validator: (girilendeg) {
            Pattern pattern =
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp regex = new RegExp(pattern);
            if (!regex.hasMatch(girilendeg))
              return 'İnvalid mail';
            else
              return null;
          },
          onSaved: (girilendeg) {
            mail = girilendeg;
          },
        ),
      ),
      Step(
        title: Text("Password:"),
        subtitle: Text("Enter your password"),
        state: Statleriayarla(2),
        isActive: true,
        content: TextFormField(
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          textInputAction: TextInputAction.done,
          key: key2,
          decoration: InputDecoration(
            icon: Icon(Icons.lock),
            labelText: "Sifre",
            hintText: "******",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            enabled: true,
            alignLabelWithHint: true,
            contentPadding: EdgeInsets.all(11),
          ),

          onSaved: (girilendeg) {
            sifre = girilendeg;
          },
        ),
      ),
    ];
    return stepler;
  }

  StepState Statleriayarla(int oankistep) {
    if (_aktifstep == oankistep) {
      if (hata) {
        return StepState.error;
      } else {
        return StepState.editing;
      }
    } else {
      return StepState.complete;
    }
  }

  void _ileributonkontrol() {
    switch (_aktifstep) {
      case 0:
        if (key0.currentState.validate()) {
          key0.currentState.save();
          hata = false;
          _aktifstep = 1;
        } else {
          hata = true;
        }
        break;
      case 1:
        if (key1.currentState.validate()) {
          key1.currentState.save();
          hata = false;
          _aktifstep = 2;
        } else {
          hata = true;
        }
        break;
      case 2:
        if (key2.currentState.validate()) {
          key2.currentState.save();
          hata = false;
          _aktifstep = 2;
          formtamamlandi();
        } else {
          hata = true;
        }
        break;
    }
  }

  void formtamamlandi()async {

    debugPrint("girilen değerler, isim:$isim,,mail:$mail,,sifre:$sifre");
    bool result = await DataConnectionChecker().hasConnection;

    if(result == true) {

      _emailvesifregirisyap();
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.sms_failed),
                  SizedBox(width: 50),
                  Text("BAŞARISIZ"),
                ],
              ),
              content: Text("Sisteme girebilmeniz için lütfen telefonunuzu internete bağlayınız !!!"),
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
      print('No internet :( Reason:');
    }

    /* if (isimkey == isim && mail == mailkey && sifre == sifrekey) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("username, email and password Correct congratulations "),
              //--------------------------------
              content: RaisedButton(
                  child: Text("Tamam"),
                  onPressed: () {
                    setState(() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Mainpage()));
                    });
                  }),
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("username, email or password incorrect"),
              content: Text("Please Try again"),
            );
          });
    }
    */
  }

  //---------------------------------authenticaiton---------------------------------------------------------------

  void _emailvesifregirisyap() {
    String mailss = mail;
    String sifress = sifre;

    _auth.signInWithEmailAndPassword(email: mailss, password: sifress).then((oturumacmiskullanici) {
      if(oturumacmiskullanici.user.emailVerified){
        mesaj+="\nEmail onaylı kullanıcı yönlendirme yapabilirsin";
        showDialog(

            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  children: [
                  Image.network('https://img2.pngindir.com/20180727/boa/kisspng-social-media-check-mark-symbol-computer-icons-user-blue-tic-5b5b96fb7c42b0.654125411532729083509.jpg',
                  width: 50, height: 50, fit: BoxFit.contain,),
                    SizedBox(width: 50,),
                    Text("BAŞARILI "),

                  ],
                ),
                //--------------------------------
                content:  Text("Sisteme giriş yapmak için tamama tıklayınız"),
                actions: <Widget>[ TextButton(
                    child: Text("Tamam"),
                    onPressed: () {
                      setState(() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Mainpage()));
                      });
                    }),
                ],
              );
            });
      }
      else{
        mesaj+="\nEmailinize mail attık lütfen onaylayın";
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  children: [
                    Image.network('https://img2.pngindir.com/20180314/dre/kisspng-error-message-icon-warning-icons-5aa8e8c4d021e4.3508332815210190768525.jpg',
                      width: 50, height: 50, fit: BoxFit.contain,),
                    SizedBox(width: 50),
                    Text("BAŞARISIZ"),
                  ],
                  ),
                content: Text("Mailinizi onaylamadınız lütfen mail adresinize attığımız maili onaylayin !"),
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
        _auth.signOut();
      }
      setState(() {

      });
    }).catchError((hata){
      debugPrint(hata.toString());
      setState(() {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  children: [
                    Image.network('https://img2.pngindir.com/20180314/dre/kisspng-error-message-icon-warning-icons-5aa8e8c4d021e4.3508332815210190768525.jpg',
                      width: 50, height: 50, fit: BoxFit.contain,),
                    SizedBox(width: 50),
                    Text("BAŞARISIZ"),
                  ],
                ),
                content: Text("Kullanici adı , e-mail yada sifre yanlış lütfen bir daha deneyin"),
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
        mesaj+="\nEmail/Sifre hatalı";

      });

    });
  }

  void _googlegiris() async{

    bool result = await DataConnectionChecker().hasConnection;
    if(result == true) {
      _googleauth.signIn().then((sonuc){
        sonuc.authentication.then((googlekeys) {
          AuthCredential credential=GoogleAuthProvider.credential(idToken: googlekeys.idToken,accessToken: googlekeys.accessToken);
          _auth.signInWithCredential(credential).then((userAuthResult) {
            var user1=userAuthResult.user;

            setState(() {
              mesaj+="\n Gmail ile giriş yapıldı \n user id:${user1.uid}\n Mail:${user1.email}";
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Row(
                        children: [
                          Image.network('https://img2.pngindir.com/20180727/boa/kisspng-social-media-check-mark-symbol-computer-icons-user-blue-tic-5b5b96fb7c42b0.654125411532729083509.jpg',
                            width: 50, height: 50, fit: BoxFit.contain,),
                          SizedBox(width: 50),
                          Text("BAŞARILI "),

                        ],
                      ),
                      //--------------------------------
                      content:  Text("Sisteme giriş yapmak için tamama tıklayınız"),
                      actions: <Widget>[ TextButton(
                          child: Text("Tamam"),
                          onPressed: () {
                            setState(() {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => Mainpage()));
                            });
                          }),
                      ],
                    );
                  });
            });

          }).catchError((hata){
            setState(() {
              mesaj+="\n firebase ve google hatası : $hata";
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Row(
                        children: [
                          Image.network('https://img2.pngindir.com/20180314/dre/kisspng-error-message-icon-warning-icons-5aa8e8c4d021e4.3508332815210190768525.jpg',
                            width: 50, height: 50, fit: BoxFit.contain,),
                          SizedBox(width: 50),
                          Text("BAŞARISIZ"),
                        ],
                      ),
                      content: Text("google authentication hatası : $hata"),
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
        }).catchError((hata){
          setState(() {
            mesaj+="\n google authentication hatası : $hata";
          });});
      } ).catchError((hata){
        setState(() {
          mesaj+="\n google auth sign in hatası : $hata";
        });
      });

    }
    else
      {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  children: [
                    Icon(Icons.sms_failed),
                    SizedBox(width: 50),
                    Text("BAŞARISIZ"),
                  ],
                ),
                content: Text("Sisteme girebilmeniz için lütfen telefonunuzu internete bağlayınız !!!"),
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
      }



  }

}




