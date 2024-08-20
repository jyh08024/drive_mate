import 'package:flutter/material.dart';

enum Palette {

  main(Color(0xFF03cf5d)),
  err(Color(0xffd62527)),
  splashBackground(Color(0xff141517)),
  defBackground(Color(0xff0e0f10)),
  whiteMain(Color(0xffffffff)),
  white2(Color(0xfff9f9f9));

  final Color color;

  const Palette(this.color);

}
