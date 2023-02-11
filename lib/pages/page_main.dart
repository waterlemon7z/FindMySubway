import 'package:flutter/material.dart';
import 'package:find_my_subway/data/get_data.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState()
  {
    super.initState();
    Network xmlData = Network("http://swopenapi.seoul.go.kr/api/subway/sample/json/realtimeStationArrival/0/5/망포");
    xmlData.getXmlData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("main"),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: Text("1"),
    );
  }
}
