import 'package:flutter/material.dart';
class GecislirenkContainer extends StatelessWidget {
  final Widget child;
  final MaterialColor renk;
  GecislirenkContainer({@required this.child,@required this.renk});
  @override
  Widget build(BuildContext context) {
    return Container(
      child:child ,
      decoration: BoxDecoration(gradient: LinearGradient(colors: [renk[700],renk[300],renk[200]],begin: Alignment.topCenter,end: Alignment.bottomCenter,stops: [0.1,0.9,1])),
    );
  }
}
