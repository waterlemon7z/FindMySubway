// ignore_for_file: use_build_context_synchronously

import 'package:find_my_subway/data/data_set.dart';
import 'package:find_my_subway/data/data_to_list.dart';
import 'package:find_my_subway/data/database.dart';
import 'package:find_my_subway/data/search_data_verify.dart';
import 'package:find_my_subway/main.dart';
import 'package:find_my_subway/pages/page_favorite.dart';
import 'package:find_my_subway/theme.dart';
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
      // backgroundColor: const Color(0xff000000),
      centerTitle: false,
      elevation: 0,
      title: Text(
        titleName,
        style: const TextStyle(
          // color: Color(0xffffffff),
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

  SearchAppbar({required this.titleName, required this.myDb});

  // ThemeColors theme = new ThemeColors();
  final ThemeData curTheme = (MyApp.themeNotifier.value == ThemeMode.light ? ThemeColors().light : ThemeColors().dark);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      elevation: 0,
      title: Text(
        titleName,
      ),
      actions: [
        IconButton(
          onPressed: () async {
            data = mapData2List(await getAllStationName());
            if (data != null) {
              showSearch(
                context: context,
                delegate: SearchPage(
                  showItemsOnEmpty: true,
                  items: data,
                  searchLabel: '???????????? ?????? ex) ?????????, K223, Gachon',
                  searchStyle: TextStyle(
                    color: (MyApp.themeNotifier.value == ThemeMode.light ? Colors.black : Colors.white),
                  ),
                  failure: const Center(
                    child: Text(
                      '?????? ?????? ????????????.',
                    ),
                  ),
                  filter: (StationInform data) => [
                    data.kName,
                    data.eName,
                    data.stCode,
                  ],
                  // sort: (a, b) => a.compareTo(b),
                  builder: (StationInform data) {
                    return ListTile(
                      leading: const IconBundang(),
                      title: Text(
                        "${data.kName} (${data.stCode})",
                      ),
                      subtitle: Text(
                        "${data.eName} / ${data.jName}",
                      ),
                      trailing: const Text(
                        '????????????',
                      ),
                      onTap: () async {
                        if (verifySearchData(data.kName, await myDb.getListFromDB())) {
                          myDb.insert(UserData(id: int.parse(data.stCode.substring(1)), stName: data.kName));
                          FavoritePageState? parent = context.findAncestorStateOfType<FavoritePageState>();
                          parent!.setState(() {
                            parent.infoList = getSubwayInfo(myDb);
                          });
                          showToast("?????????????????????", false);
                        } else
                          showToast("?????? ????????? ????????????.", false);
                      },
                      // style:ListTileStyle(
                      //
                      // ),
                    );
                  },
                  barTheme: curTheme,
                  // barTheme:ThemeData(
                  //   appBarTheme: const AppBarTheme(
                  //     color: Color(0xff000000),
                  //     elevation: 0,
                  //   ),
                  //   canvasColor: const Color(0xff000000),
                  //   hintColor: const Color(0xffffffff),
                  // )
                ),
              );
            }
          },
          icon: const Icon(
            Icons.search,
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
