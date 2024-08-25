import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/pallete.dart';

class HomePage extends StatefulWidget {

  const HomePage({ super.key });

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  Future<void> getCarList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.http('10.0.2.2', '/carList');
    var response = await http.get(url);

    await prefs.setString('carList', response.body);
  }

  Future<void> getPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('carList'));
  }

  @override
  Widget build(BuildContext context) {
    final String svgPath = 'assets/images/car_inner.svg';
    final Widget svg = SvgPicture.asset(
        svgPath,
        colorFilter: ColorFilter.mode(Colors.red, BlendMode.xor),
    );

    return Scaffold(
      backgroundColor: Palette.whiteMain.color,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100),
            ElevatedButton(
                onPressed: () {
                  getCarList();
                }, child: Text('shared 저장')
            ),
            const SizedBox(height: 100),
            ElevatedButton(
                onPressed: () {
                  getPref();
                }, child: Text('shared 블러우기')
            ),
            svg,
          ],
        ),
      )
    );
  }
}
