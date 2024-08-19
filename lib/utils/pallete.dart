import 'package:flutter/material.dart';

enum Palette {

  main(Color(0xFF03cf5d)),
  err(Color(0xffd62527)),
  splashBackground(Color(0xff141517)),
  defBackground(Color(0xff0e0f10));

  final Color color;

  const Palette(this.color);

}
