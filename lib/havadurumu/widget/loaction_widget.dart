import 'package:flutter/material.dart';
import 'package:turkish/turkish.dart';
class LocationWidget extends StatelessWidget {
  final String secilenSehir;
  LocationWidget({@required this.secilenSehir});
  @override
  Widget build(BuildContext context) {

      return Text("${turkish.toUpperCase(secilenSehir)}\n",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),);

  }
}
