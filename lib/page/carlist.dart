import 'dart:convert';

import 'package:drive_mate_real/page/car/createcar.dart';
import 'package:flutter/material.dart';

import '../../utils/pallete.dart';

import 'package:http/http.dart' as http;

class CarList extends StatefulWidget {
  const CarList({super.key});

  @override
  State<CarList> createState() => CreateCarState();
}

class CreateCarState extends State<CarList> {
  late List<dynamic> allCars = [];

  @override
  void initState() {
    super.initState();
    getCarList();
  }

  void getCarList() async {
    var url = Uri.http('10.0.2.2', '/carList');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        var jsonData = jsonDecode(response.body);
        allCars = jsonData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    List carUi = allCars.map((value) {
      return Container(
        padding:
            const EdgeInsets.only(left: 14, top: 14, right: 14, bottom: 14),
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 16, left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 2,
            color: Palette.main.color,
          ),
        ),
        child: Row(
          children: [
            Image(
              image: AssetImage('assets/images/${value['image']}'),
              width: 120,
            ),
            Container(
                margin: const EdgeInsets.only(left: 8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${value['model']}',
                        style: theme.textTheme.bodyMedium?.apply(
                          fontWeightDelta: 6,
                        ),
                      ),
                      Text(
                        '${value['number']}',
                        style: theme.textTheme.bodySmall,
                      ),
                    ]))
            // Column(
            //   children: [
            //     Text(value['model'].toString()),
            //     Text(value['number'].toString()),
            //   ],
            // )
          ],
        ),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('차량 목록'),
        backgroundColor: Palette.white2.color,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      backgroundColor: Palette.whiteMain.color,
      floatingActionButton: SizedBox(
        width: 150,
        height: 80,
        child: extendButton(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            ...carUi,
          ],
        ),
      ),
    );
  }
}

FloatingActionButton extendButton(context) {
  return FloatingActionButton.extended(
    onPressed: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const CreateCar()));
    },
    backgroundColor: Palette.main.color,
    label: Row(
      children: [
        const Text(
          '차량 등록',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(width: 5),
        Icon(
          Icons.add,
          color: Palette.whiteMain.color,
        ),
      ],
    ),
  );
}
