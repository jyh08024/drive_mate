import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/pallete.dart';

class HomePage extends StatefulWidget {

  const HomePage({ super.key });

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.whiteMain.color,
    );
  }
}