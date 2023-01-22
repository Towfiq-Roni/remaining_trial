import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import '../model/model_class.dart';
import '../util/const.dart';

class ApiService {

  Future<List<dynamic>?> getPosts() async{
    try{
      var url = Uri.parse(APIConstant.baseUrl + APIConstant.post);
      var response = await get(url);
      if(response.statusCode == 200){
        List<dynamic> _model = json.decode(response.body);
        return _model;
      }
    } catch(e){
      log(e.toString());
    }
  }

  Future<Response> postPosts(String id, String title, String body) async{
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

  Future<List<Posts>?> deletePosts(int id) async{
    try{
      var url = Uri.parse('${APIConstant.baseUrl}${APIConstant.post}/$id');
      var response = await delete(url);
      if(response.statusCode == 200){
        print('deleted $id');
        // List<Posts> _model = json.decode(response.body);
        // return _model;
      }
    } catch(e){
      log(e.toString());
    }
  }

  Future<List<Posts>?> putPosts() async{
    try{
      var url = Uri.parse('${APIConstant.baseUrl}${APIConstant.post}/1');
      var response = await put(url);
      if(response.statusCode == 200){
        List<Posts> _model = json.decode(response.body);
        return _model;
      }
    } catch(e){
      log(e.toString());
    }
  }

  Future<List<Posts>?> patchPosts() async{
    try{
      var url = Uri.parse('${APIConstant.baseUrl}${APIConstant.post}/1');
      var response = await patch(url);
      if(response.statusCode == 200){
        List<Posts> _model = json.decode(response.body);
        return _model;
      }
    } catch(e){
      log(e.toString());
    }
  }
}