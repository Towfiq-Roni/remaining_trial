// import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import '../repo/service.dart';

class HttpRequestsSecondScreen extends StatefulWidget {
  const HttpRequestsSecondScreen({Key? key}) : super(key: key);

  @override
  State<HttpRequestsSecondScreen> createState() =>
      _HttpRequestsSecondScreenState();
}

class _HttpRequestsSecondScreenState extends State<HttpRequestsSecondScreen> {
  TextEditingController idController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController userIdController = TextEditingController();

  ImagePicker picker = ImagePicker();
  XFile? xImageFile;
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          'Second HTTP Screen',
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          children: [
            TextFormField(
              controller: idController,
              decoration: const InputDecoration(
                hintText: 'Enter ID',
              ),
            ),
            TextFormField(
              controller: userIdController,
              decoration: const InputDecoration(
                hintText: 'Enter User ID',
              ),
            ),
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'Enter Title',
              ),
            ),
            TextFormField(
              controller: bodyController,
              decoration: const InputDecoration(
                hintText: 'Enter Body',
              ),
            ),
            Row(
              children: [
                const Spacer(
                  flex: 2,
                ),
                ElevatedButton(
                    onPressed: () async {
                      Response response = await ApiService().putPosts(
                          idController.text,
                          userIdController.text,
                          titleController.text,
                          bodyController.text);
                      print(response.body);
                      // setState(() {
                      //
                      // });
                      response.statusCode == 200
                          // ? Navigator.push(
                          // context,
                          // MaterialPageRoute(
                          //     builder: (context) =>
                          //     const HttpRequestsSecondScreen()))
                          ? ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Put')))
                          : ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Something went wrong')));
                    },
                    child: const Text('PUT')),
                const Spacer(
                  flex: 1,
                ),
                ElevatedButton(
                    onPressed: () async {
                      Response response = await ApiService().patchPosts(
                          idController.text,
                          userIdController.text,
                          titleController.text,
                          bodyController.text);
                      print(response.body);
                      // setState(() {
                      //
                      // });
                      response.statusCode == 200
                          // ? Navigator.push(
                          // context,
                          // MaterialPageRoute(
                          //     builder: (context) =>
                          //     const HttpRequestsSecondScreen()))
                          ? ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Patched')))
                          : ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Something went wrong')));
                    },
                    child: const Text('PATCH')),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () async {
                  xImageFile = (await picker.pickImage(source: ImageSource.gallery))!;
                  imageFile = File(xImageFile!.path);
                  // Image.file(File(xImageFile!.path));
                  StreamedResponse response = (await ApiService()
                      .uploadPhotos(imageFile!));
                  response.statusCode == 200
                      ? ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Uploaded')))
                      : ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Something went wrong')));
                },
                child: const Text('Upload Image')),
            Expanded(
              child: imageFile != null
                  ? Image.file(File(imageFile!.path))
                  : Text('No Image'),
            ),
          ],
        ),
      ),
    );
  }

  // _getImageFromGallery() async {
  //   PickedFile pickedFile = (await ImagePicker()
  //       .pickImage(source: ImageSource.gallery)) as PickedFile;
  //   if (pickedFile != null){
  //     setState(() {
  //       imageFile = File(pickedFile.path);
  //     });
  //   }
  // }
}
