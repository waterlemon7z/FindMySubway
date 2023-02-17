import 'package:find_my_subway/data/data_set.dart';
import 'package:find_my_subway/widgets/widget_search_item.dart';
import 'package:flutter/material.dart';
import 'package:searchable_listview/searchable_listview.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<StationInform> data = [
    StationInform(stCode: "K209", kName: "청량리", eName: "청량리", jName: "청량리"),
    StationInform(stCode: "K210", kName: "왕십리", eName: "청량ㅇ리", jName: "청량ㅇ리"),
    StationInform(stCode: "K211", kName: "청ㅇㅇ량리", eName: "청량ㅇ리", jName: "청ㅇㅇ량리")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: Appbars(titleName: "지하철 역 검색"),
      backgroundColor: Color(0xff000000),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SearchableList<StationInform>(
          onPaginate: () async {
            await Future.delayed(const Duration(milliseconds: 1000));
            setState(() {
              data.addAll([
                StationInform(stCode: "K210", kName: "111", eName: "23", jName: "32"),
                StationInform(stCode: "K220", kName: "123", eName: "323", jName: "232"),
                StationInform(stCode: "K230", kName: "12312", eName: "청량3232ㅇ리", jName: "2323"),
              ]);
            });
          },
          builder: (StationInform stInfo) => SearchItem(data: stInfo),
          loadingWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              SizedBox(
                height: 20,
              ),
              Text('Loading actors...')
            ],
          ),
          errorWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.error,
                color: Colors.red,
              ),
              SizedBox(
                height: 20,
              ),
              Text('Error while fetching actors')
            ],
          ),
          emptyWidget: EmptyView(),
          asyncListCallback: () async {
            await Future.delayed(
              const Duration(
                milliseconds: 0,
              ),
            );
            return data;
          },
          asyncListFilter: (q, list) {
            return list.where((element) => element.kName.contains(q)).toList();
          },
          // emptyWidget: const EmptyView(),
          onRefresh: () async {},
          onItemSelected: (data) {},
          inputDecoration: InputDecoration(
            labelText: "역명으로 검색",
            fillColor: Colors.white,
            labelStyle: TextStyle(color: Color(0xffffffff)),
            // enabledBorder: OutlineInputBorder(
            //   borderSide: const BorderSide(
            //     color: Colors.white,
            //     width: 1.0,
            //   ),
            // ),
            // helperText: "역명 검색하기",helperStyle: TextStyle(color:Color(0xffffffff)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.error,
          color: Colors.red,
        ),
        Text('no actor is found with this name'),
      ],
    );
  }
}
