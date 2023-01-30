import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController searchController = TextEditingController();
  bool? _search = false;

  List<dynamic> _data = [
    'abracadabra',
    'open sesame',
    'avada kedavra',
    'chu mantar chu',
    'majikku'
  ];
  List<dynamic> _searchData = [];

  @override
  void dispose(){
    searchController.dispose();
    super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: _search != true
            ? const Text('Search')
            : TextField(
                controller: searchController,
                onChanged: (value){
                  setState(() {
                    // searchController.text = value;
                    // if(value != null) {
                      _data.retainWhere((value) =>
                          value.startsWith('${searchController.text}'));
                    // }
                  });
                },
              ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _search = true;
                });
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: _search != true
      ? ListView.separated(
        shrinkWrap: true,
          itemBuilder: (context, index){
            return Container(
              margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
              color: Colors.grey,
              child: Text(_data[index]),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
          const Divider(
            color: Colors.white,
            height: 10,
          ),
          itemCount: _data.length)
        : ListView.separated(
        shrinkWrap: true,
          itemBuilder: (context, index){
            return Container(
              margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
              color: Colors.grey,
              child: Text(_data[index]),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
          const Divider(
            color: Colors.white,
            height: 10,
          ),
          itemCount: _data.length),
    );
  }
}
