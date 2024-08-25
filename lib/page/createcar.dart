import 'dart:convert';
import 'dart:io';

import 'package:drive_mate_real/page/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../utils/pallete.dart';

class CreateCar extends StatefulWidget {

  const CreateCar({super.key});

  @override
  State<CreateCar> createState() => CreateCarState();
}

class CreateCarState extends State<CreateCar> {
  XFile? imageFile;

  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  Future<void> collectImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);

    if (image != null) {
      setState(() {
        this.imageFile = image;
      });
    }
  }

  void submit() async {
    var body = {
      "model": controller.text,
      "number": controller2.text,
    };

    if (imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('이미지를 선택해주세요'),
        duration: Duration(milliseconds: 500),
      ));

      return;
    }

    if (body['model'] == '') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('차종을 입력해주세요'),
          duration: Duration(milliseconds: 500),
      ));

      return;
    }

    if (body['number'] == '') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('차량번호를 입력해주세요'),
        duration: Duration(milliseconds: 500),
      ));

      return;
    }

    var url = Uri.http('10.0.2.2', '/add/car');
    final request = http.MultipartRequest('POST', url);

    request.fields.addAll(body);
    request.files.add(await http.MultipartFile.fromPath("image", imageFile!.path));

    final response = await request.send();
    final responseBody = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check),
              SizedBox(width: 6),
              Text("등록되었습니다."),
            ],
          )
      ));

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error),
              SizedBox(width: 6),
              Text("에러가 발생했습니다."),
            ],
          )
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('차량 등록'),
        backgroundColor: Palette.white2.color,
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      backgroundColor: Palette.whiteMain.color,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('사진 등록',
                style: theme.textTheme.bodySmall?.apply(
                  fontSizeDelta: 6,
                  fontWeightDelta: 6
                ),
              ),
              const SizedBox(height: 6),
              Column(
                children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 52,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey,
                      ),
                      child: imageFile == null
                        ? const Icon(Icons.camera_alt, color: Colors.white, size: 60,)
                        : Image.file(File(imageFile!.path)),
                    ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () {
                            collectImage(ImageSource.camera);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16),
                            backgroundColor: Palette.main.color,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.camera_alt, color: Colors.white,),
                              Text('카메라',
                                style: theme.textTheme.bodyMedium?.apply(
                                    color: Colors.white
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () {
                            collectImage(ImageSource.gallery);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16),
                            backgroundColor: Palette.main.color,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.photo_library, color: Colors.white,),
                              Text('갤러리',
                                style: theme.textTheme.bodyMedium?.apply(
                                    color: Colors.white
                                ),
                              )
                            ],
                          ),
                        )
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: Colors.black12,
                  ),
                  const SizedBox(height: 24),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text('차량 정보',
                      style: theme.textTheme.bodySmall?.apply(
                          fontSizeDelta: 6,
                          fontWeightDelta: 6
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      labelText: '차종',
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: controller2,
                    decoration: const InputDecoration(
                      labelText: '차량번호',
                    ),
                  ),
                  const SizedBox(height: 24),

                  ElevatedButton(
                    onPressed: () {
                      submit();
                    },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Palette.main.color,
                        padding: const EdgeInsets.all(14),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.check, color: Colors.white,),
                          const SizedBox(width: 6,),
                          Text('등록하기',
                            style: theme.textTheme.bodyMedium?.apply(
                              color: Colors.white,
                            ),
                          )
                        ],
                      )
                  )
                ],
              ),
            ],
          )
        )
      ),
    );
  }
}