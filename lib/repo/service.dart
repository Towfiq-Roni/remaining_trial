import 'dart:convert';
import 'dart:developer';
import 'dart:io';

// import 'dart:html';
// import 'dart:html';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import '../model/model_class.dart';
import '../util/const.dart';

// import 'package:flutter/services.dart' show rootBundle;
// import 'package:path_provider/path_provider.dart';
import 'package:http_parser/http_parser.dart';

class ApiService {
  Future<List<dynamic>?> getPosts() async {
    try {
      var url = Uri.parse(APIConstant.baseUrl + APIConstant.post);
      var response = await get(url);
      if (response.statusCode == 200) {
        List<dynamic> _model = json.decode(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<Response> postPosts(String id, String title, String body) async {
    return post(
      Uri.parse(APIConstant.baseUrl + APIConstant.post),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': id,
        'title': title,
        'body': body,
      }),
    );
    // try{
    //   var url = Uri.parse(APIConstant.baseUrl + APIConstant.post);
    //   var response = await post(url);
    //   if(response.statusCode == 201){
    //     List<Posts> _model = json.decode(response.body);
    //     return _model;
    //   }
    // } catch(e){
    //   log(e.toString());
    // }
  }

  // Future uploadPhotos(File img) async{
  //   var req = MultipartRequest("POST",
  //       Uri.parse('${APIConstant.baseUrl}${APIConstant.photos}'));
  //   req.files.add(await MultipartFile.fromBytes('file', img.readAsBytesSync(), filename: 'upload.png', contentType: MediaType('image', 'png')));
  //   var response = await req.send();
  //   // File imageFile = File(imageFile.path);
  //   // var responsed = await Response.fromStream(response);
  //   // final responseData = jsonDecode(responsed.body);
  //
  //   if(response.statusCode == 200){
  //     print('Working');
  //     // print(responseData);
  //   }
  //   else{
  //     print('Error');
  //   }
  //
  //   // try{
  //   //   if()
  //   // } catch(e){
  //   //
  //   // }
  // }

  Future<StreamedResponse> uploadPhotos(File image) async {
    // final byteData = await rootBundle.load('assets/$paths');
    // File file = File('${(await getTemporaryDirectory()).path}/$paths');
    // await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    var req = MultipartRequest(
        "POST", Uri.parse('${APIConstant.baseUrl}${APIConstant.photos}'));
    // var picture = await MultipartFile.fromPath("file", file.path);
    // req.files.add(picture);
    req.files.add(await MultipartFile.fromBytes('file', image.readAsBytesSync(),
        filename: 'Image.jpg', contentType: MediaType('image', 'jpg')));
    var response = await req.send();
    // File imageFile = File(imageFile.path);
    // var responsed = await Response.fromStream(response);
    // final responseData = jsonDecode(responsed.body);

    if (response.statusCode == 200) {
      print('Working');
      // print(responseData);
    } else {
      print('Not Working');
    }
    return response;
    // try{
    //   if()
    // } catch(e){
    //
    // }
  }

  Future<List<Posts>?> deletePosts(int id) async {
    try {
      var url = Uri.parse('${APIConstant.baseUrl}${APIConstant.post}/$id');
      var response = await delete(url);
      if (response.statusCode == 200) {
        print('deleted $id');
        // List<Posts> _model = json.decode(response.body);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<Response> putPosts(
      String id, String userId, String title, String body) async {
    return put(
      Uri.parse('${APIConstant.baseUrl}${APIConstant.post}/1'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': id,
        'userId': userId,
        'title': title,
        'body': body,
      }),
    );
  }

  Future<Response> patchPosts(
      String? id, String? userId, String? title, String? body) async {
    return patch(
      Uri.parse('${APIConstant.baseUrl}${APIConstant.post}/1'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': id!,
        'userId': userId!,
        'title': title!,
        'body': body!,
      }),
    );
  }
}
