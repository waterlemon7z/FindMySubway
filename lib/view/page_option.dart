import 'package:find_my_subway/entity/UserSettingsEntity.dart';
import 'package:find_my_subway/main.dart';
import 'package:find_my_subway/service/UserSettingsService.dart';
import 'package:find_my_subway/service/UserSubwayService.dart';
import 'package:find_my_subway/view/widgets/widget_appbar.dart';
import 'package:find_my_subway/view/widgets/widget_showToast.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

enum ThemeItem { lightTheme, darkTheme, systemDefault }

class OptionPage extends StatefulWidget {
  @override
  State<OptionPage> createState() => _OptionPageState();
}

class _OptionPageState extends State<OptionPage> {
  // final firestore = FirebaseFirestore.instance;
  ThemeItem? selectedMenu = ThemeItem.darkTheme;
  final _userSettingService = GetIt.I<UserSettingsService>();
  final UserSubwayService _userSubwayService = UserSubwayService();

  /*
  Future<void> _AddFriendPopUp(BuildContext context) async {
    final TextEditingController _textFieldController = TextEditingController();
    int uid = box.get("FriendCode")!;
    var uData = await firestore.collection("CurrentLoc").doc(uid.toString()).get();
    return showDialog(
        context: context,
        builder: (context) {
          String curName = uData["ID"];
          String? valueText;
          String changedName;
          return AlertDialog(
            title: const Text('이름 변경하기'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("현재 이름 : $curName"),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      valueText = value;
                    });
                  },
                  controller: _textFieldController,
                  decoration: const InputDecoration(hintText: "친구의 ID 입력하기"),
                ),
              ],
            ),
            actions: <Widget>[
              MaterialButton(
                // color: Colors.transparent,
                textColor: Colors.black,
                child: const Text('취소하기'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              MaterialButton(
                // color: Colors.green,
                textColor: Colors.black,
                child: const Text('추가하기'),
                onPressed: () {
                  setState(() {
                    changedName = valueText!;
                    if (changedName.length >= 2 && changedName.length <= 10) {
                      firestore.collection("CurrentLoc").doc(uid.toString()).update(<String, String>{"ID": changedName});
                      Navigator.pop(context);
                    } else
                      showToast("2~10글자만 가능합니다.", true);
                  });
                },
              ),
            ],
          );
        });
  }*/
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbars(titleName: "설정"),
      body: Column(
        children: [
          ListTile(
            title: const Text("테마 변경 하기"),
            trailing: const Text("라이트테마 <-> 다크테마"),
            onTap: () {
              if (FindMySubwayApp.themeNotifier.value == ThemeMode.light) {
                FindMySubwayApp.themeNotifier.value = ThemeMode.dark;
                _userSettingService.updateTheme(1);
              } else {
                FindMySubwayApp.themeNotifier.value = ThemeMode.light;
                _userSettingService.updateTheme(0);
              }
            },
          ),
          ListTile(
            enabled: false,
            title: const Text("지하철 현재 위치 표시 여부"),
            trailing: const Text("(공사중) 보이기 <-> 숨기기"),
            onTap: () {
              var settingData = _userSettingService.getSettingData();
              if (settingData.location == 0) {
                _userSettingService.updateLocation();
                showToast("지하철 현재 위치 보여짐", false);
              } else {
                _userSettingService.updateLocation();
                showToast("지하철 현재 위치 숨겨짐", false);
              }
            },
          ),
          ListTile(
            title: const Text("자동 새로고침"),
            trailing: const Text("활성화 <-> 비활성화"),
            onTap: () {
              var settingData = _userSettingService.getSettingData();
              if (!settingData.autoTimer) {
                _userSettingService.updateAutoTimer();
                showToast("자동새로고침 활성화됨", false);
              } else {
                _userSettingService.updateAutoTimer();
                showToast("자동새로고침 비활성화됨", false);
              }
            },
          ),
          /*
          ListTile(
            title: const Text("친구 기능"),
            trailing: const Text("활성화 <-> 비활성화"),
            onTap: () {
              if (box.get("FriendFunc") == false) {
                box.put("FriendFunc", true);
                if (box.get("FriendCode") == -1) {
                  while (true) {
                    try {
                      int temp = Random().nextInt(9999999) + 10000000;
                      firestore.collection("CurrentLoc").doc(temp.toString()).get();
                      box.put("FriendCode", temp);
                      break;
                    } catch (e) {
                      // int temp = Random().nextInt(9999999) + 10000000;
                    }
                  }
                }
                showToast("친구기능 활성화됨", false);
              } else {
                box.put("FriendFunc", false);
                showToast("친구기능 비활성화됨", false);
              }
            },
          ),
          ListTile(
            title: const Text("친구 표시 이름 변경"),
            onTap: () async {
              await _AddFriendPopUp(context);
            },
          ),*/
          ListTile(
            title: const Text("데이터 초기화"),
            // trailing: Text("라이트테마 <-> 다크테마"),
            onTap: () {
              _userSubwayService.reset();
              showToast("초기화 되었습니다", true);
            },
          ),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                ListTile(
                  // title: Text("데이터 초기화"),
                  trailing: Text("ver. 240105"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
