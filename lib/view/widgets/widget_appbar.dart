// ignore_for_file: use_build_context_synchronously, must_be_immutable
import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:find_my_subway/data/api/get_data.dart';
import 'package:find_my_subway/data/data_msg_parse.dart';
import 'package:find_my_subway/data/data_set.dart';
import 'package:find_my_subway/data/search_data_verify.dart';
import 'package:find_my_subway/data/theme.dart';
import 'package:find_my_subway/entity/UserSubwayDataEntity.dart';
import 'package:find_my_subway/main.dart';
import 'package:find_my_subway/view/page_favorite.dart';
import 'package:find_my_subway/service/UserSubwayService.dart';
import 'package:find_my_subway/view//widgets/widget_arrivals/widget_line_icon.dart';
import 'package:find_my_subway/view/widgets/widget_showToast.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:search_page/search_page.dart';

class Appbars extends StatelessWidget implements PreferredSizeWidget {
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

class SearchAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String titleName = "즐겨찾는 지하철 역";
  final _userSubwayService = GetIt.I.get<UserSubwayService>();
  late List<StationInform> data;

  // ThemeColors theme = new ThemeColors();
  final ThemeData curTheme = (FindMySubwayApp.themeNotifier.value == ThemeMode.light ? ThemeColors().light : ThemeColors().dark);

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
            data = SubwayListDataSet.allStationData;
            showSearch(
              context: context,
              delegate: SearchPage(
                showItemsOnEmpty: true,
                items: data,
                searchLabel: '지하철역 검색 ex) 가천대, K223',
                searchStyle: TextStyle(
                  color: (FindMySubwayApp.themeNotifier.value == ThemeMode.light ? Colors.black : Colors.white),
                ),
                failure: const Center(
                  child: Text(
                    '해당 역은 없습니다.',
                  ),
                ),
                filter: (StationInform data) => [
                  data.kName,
                  data.stCode,
                ],
                // sort: (a, b) => a.compareTo(b),
                builder: (StationInform data) {
                  return ListTile(
                    leading: LineIcon.icons[data.line],
                    title: Text(
                      "${data.kName} (${data.stCode})",
                    ),
                    trailing: const Text(
                      '추가하기',
                    ),
                    onTap: () async {
                      if (verifySearchData(Pair(data.kName, data.line), await _userSubwayService.getUserData())) {
                        _userSubwayService.insert(UserSubwayDataEntity(id: parseStationId(data.stCode), stName: data.kName, line: data.line, idx: 0));
                        FavoritePageState? parent = context.findAncestorStateOfType<FavoritePageState>();
                        parent!.setState(() {
                          parent.infoList = DataFromAPI.getSubwayInfo();
                        });
                        showToast("추가되었습니다", false);
                      } else
                        showToast("이미 추가된 역입니다.", false);
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
