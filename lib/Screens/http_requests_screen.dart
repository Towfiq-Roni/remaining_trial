import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:remaining_trial/Screens/http_requests_second_screen.dart';

import '../model/model_class.dart';
import '../repo/service.dart';

class HttpRequestsScreen extends StatefulWidget {
  const HttpRequestsScreen({Key? key}) : super(key: key);

  @override
  State<HttpRequestsScreen> createState() => _HttpRequestsScreenState();
}

class _HttpRequestsScreenState extends State<HttpRequestsScreen> {
  late List<dynamic> _posts = [];
  // late List<dynamic> _searchPosts = [];

  // late dynamic _dposts = [];
  // late List<dynamic> _cposts = [];
  late dynamic posts;
  TextEditingController idController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  // TextEditingController searchController = TextEditingController();
  // bool? _search = false;

  @override
  void initState() {
    super.initState();
    _getData();
    // _deleteData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _getData() async {
    _posts = (await ApiService().getPosts())!;
    Future.delayed(const Duration(seconds: 2)).then((value) => setState(() {}));
  }

  // void _deleteData() async {
  //   _dposts = (await ApiService().deletePosts(_dposts[int]))!;
  //   Future.delayed(const Duration(seconds: 2)).then((value) => setState(() {}));
  // }

  // void _createData(String id, String title, String body) async {
  //   _cposts = (await ApiService().postPosts(id, title, body)) as List;
  //   Future.delayed(const Duration(seconds: 2)).then((value) => setState(() {}));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:
        // _search != true ?
        const Text(
          'Posts',
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
        ),
        //     : TextField(
        //   controller: searchController,
        //   textInputAction: TextInputAction.search,
        // ),
        // actions: [
        //   IconButton(onPressed: (){
        //     _getData().then((value) {
        //       setState(() {
        //         _search = true;
        //         _searchPosts = _posts;
        //         _searchPosts.retainWhere((element) => element.startsWith('searchController.text'));
        //         // searchController.text = value;
        //         // value = _searchPosts;
        //         // titleController = idController;
        //       });
        //     });
        //   }, icon: const Icon(Icons.search, color: Colors.black,))
        // ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            children: [
              // _search != true ?
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _posts[index]['id'].toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.black),
                          ),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        Expanded(
                          child: Text(
                            _posts[index]['title'],
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.black),
                          ),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        GestureDetector(
                          child: const Icon(Icons.delete),
                          onTap: () async {
                            await ApiService().deletePosts(_posts[index]['id']);
                          },
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  color: Colors.white,
                  height: 10,
                ),
              )
              // : ListView.separated(
              //   physics: const NeverScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   itemCount: _searchPosts.length,
              //   itemBuilder: (context, index) {
              //     return Container(
              //       padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              //       decoration: BoxDecoration(
              //         color: Colors.grey.shade300,
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //       child: Row(
              //         children: [
              //           Expanded(
              //             child: Text(
              //               _searchPosts[index]['id'].toString(),
              //               style: const TextStyle(
              //                   fontWeight: FontWeight.w500,
              //                   fontSize: 16,
              //                   color: Colors.black),
              //             ),
              //           ),
              //           const Spacer(
              //             flex: 1,
              //           ),
              //           Expanded(
              //             child: Text(
              //               _searchPosts[index]['title'],
              //               style: const TextStyle(
              //                   fontWeight: FontWeight.w400,
              //                   fontSize: 16,
              //                   color: Colors.black),
              //             ),
              //           ),
              //           const Spacer(
              //             flex: 1,
              //           ),
              //           GestureDetector(
              //             child: const Icon(Icons.delete),
              //             onTap: () async {
              //               await ApiService().deletePosts(_posts[index]['id']);
              //             },
              //           ),
              //         ],
              //       ),
              //     );
              //   },
              //   separatorBuilder: (BuildContext context, int index) =>
              //       const Divider(
              //     color: Colors.white,
              //     height: 10,
              //   ),
              // ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade700,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  child: AnimatedPadding(
                    padding: MediaQuery.of(context).viewInsets,
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.decelerate,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: idController,
                          decoration: const InputDecoration(
                            hintText: 'Enter ID',
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
                        ElevatedButton(
                            onPressed: () async {
                              Response response = await ApiService().postPosts(
                                  idController.text,
                                  titleController.text,
                                  bodyController.text);
                              print(response.body);
                              // setState(() {
                              //
                              // });
                              response.statusCode == 201
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HttpRequestsSecondScreen()))
                                  // ? ScaffoldMessenger.of(context).showSnackBar(
                                  //     SnackBar(content: Text('Posted')))
                                  : ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Something went wrong')));
                            },
                            child: const Text('Post')),
                      ],
                    ),
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // Future<dynamic> showSearch<String>({
  //
  // })
}
