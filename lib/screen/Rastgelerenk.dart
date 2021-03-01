import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as mathematic;

Color rastgeleRenk() {
  return Color.fromARGB(
      mathematic.Random().nextInt(255),
      mathematic.Random().nextInt(255),
      mathematic.Random().nextInt(255),
      mathematic.Random().nextInt(255));
}
