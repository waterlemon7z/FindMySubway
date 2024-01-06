import 'package:find_my_subway/data/api/get_data.dart';
import 'package:find_my_subway/data/data_msg_parse.dart';
import 'package:find_my_subway/data/search_data_verify.dart';
import 'package:find_my_subway/entity/UserSubwayDataEntity.dart';
import 'package:find_my_subway/repository/UserSubwayRepository.dart';
import 'package:find_my_subway/view/page_favorite.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../view/widgets/widget_showToast.dart';

class UserSubwayService {
  final UserSubwayRepository _userSubwayRepository = UserSubwayRepository();

  Future<List<UserSubwayDataEntity>> getUserData() async {
    return await _userSubwayRepository.findAll();
  }

  Future insertNewStation(UserSubwayDataEntity entity, BuildContext context) async {
    var usrData = await getUserData();
    if (verifySearchData(entity, usrData)) {
      entity.idx = usrData.length;
      _userSubwayRepository.insertByData(entity);
      FavoritePageState? parent = context.findAncestorStateOfType<FavoritePageState>();
      parent!.setState(() {
        parent.infoList = DataFromAPI.getSubwayInfo();
      });
      showToast("추가되었습니다", false);
    } else
      showToast("이미 추가된 역입니다.", false);
  }

  void reset() {
    _userSubwayRepository.reset();
  }

  void deleteById(String id) {
    _userSubwayRepository.deleteById(id);
  }
}
