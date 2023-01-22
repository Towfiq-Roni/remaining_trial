import 'package:flutter/material.dart';

class HttpRequestsSecondScreen extends StatefulWidget {
  const HttpRequestsSecondScreen({Key? key}) : super(key: key);

  @override
  State<HttpRequestsSecondScreen> createState() =>
      _HttpRequestsSecondScreenState();
}

class _HttpRequestsSecondScreenState extends State<HttpRequestsSecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'Second HTTP Screen',
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
