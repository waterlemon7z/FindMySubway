// ignore_for_file: use_build_context_synchronously

import 'package:find_my_subway/data/data_set.dart';
import 'package:find_my_subway/data/data_to_list.dart';
import 'package:find_my_subway/data/database.dart';
import 'package:find_my_subway/data/search_data_verify.dart';
import 'package:find_my_subway/widgets/widget_arrivals/widget_line_icon.dart';
import 'package:find_my_subway/widgets/widget_showToast.dart';
import 'package:flutter/material.dart';
import 'package:find_my_subway/data/get_data.dart';
import 'package:flutter/rendering.dart';
import 'package:search_page/search_page.dart';

class Appbars extends StatelessWidget with PreferredSizeWidget {
  final String titleName;

  Appbars({required this.titleName});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xff000000),
      centerTitle: false,
      elevation: 0,
      title: Text(
        titleName,
        style: const TextStyle(
          color: Color(0xffffffff),
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SearchAppbar extends StatelessWidget with PreferredSizeWidget {
  final String titleName;
  final UsrDataProvider myDb;
  late List<StationInform> data;
  SearchAppbar({required this.titleName,required this.myDb});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xff000000),
      centerTitle: false,
      elevation: 0,
      title: Text(
        titleName,
        style: const TextStyle(
          color: Color(0xffffffff),
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            data = mapData2List(await getAllStationName());
            showSearch(
              context: context,
              delegate: SearchPage(
                  showItemsOnEmpty: true,
                  // onQueryUpdate: print,
                  items: data,
                  searchLabel: '지하철역 검색 ex) 가천대, K223, Gachon',
                  searchStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  failure: const Center(
                    child: Text(
                      '해당 역은 없습니다.',
                      style: TextStyle(color: Color(0xffffffff)),
                    ),
                  ),
                  filter: (data) => [
                        data.kName,
                        data.eName,
                        data.stCode,
                      ],
                  // sort: (a, b) => a.compareTo(b),
                  builder: (data) {
                    return ListTile(
                      leading: const IconBundang(),
                      title: Text(
                        "${data.kName} (${data.stCode})",
                        style: const TextStyle(
                          color: Color(0xffffffff),
                        ),
                      ),
                      subtitle: Text(
                        "${data.eName} / ${data.jName}",
                        style: const TextStyle(
                          color: Color(0xffffffff),
                        ),
                      ),
                      trailing: const Text(
                        '추가하기',
                        style: TextStyle(
                          color: Color(0xffffffff),
                        ),
                      ),
                      tileColor: const Color(0xff000000),
                      onTap: () async{
                        print(data.kName);
                        if(verifySearchData(data.kName, await myDb.getListFromDB()))
                          {
                            myDb.insert(UserData(id: int.parse(data.stCode.substring(1)), stName: data.kName));
                            showToast("추가되었습니다");
                          }
                        else

                          showToast("이미 추가된 역입니다.");
                      },
                      // style:ListTileStyle(
                      //
                      // ),
                    );
                  },
                  barTheme: ThemeData(
                    appBarTheme: const AppBarTheme(
                      color: Color(0xff000000),
                      elevation: 0,
                    ),
                    canvasColor: const Color(0xff000000),
                    hintColor: const Color(0xffffffff),
                  )),
            );
          },
          icon: const Icon(
            Icons.search,
            color: Color(0xffffffff),
          ),
          // backgroundColor: Colors.transparent,
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}