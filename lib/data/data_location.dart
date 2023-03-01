import 'dart:math';
import 'package:find_my_subway/data/data_set.dart';
import 'package:find_my_subway/data/data_to_list.dart';
import 'package:find_my_subway/data/database.dart';
import 'package:find_my_subway/data/get_data.dart';
import 'package:find_my_subway/data/search_data_verify.dart';
import 'package:find_my_subway/widgets/widget_showToast.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  var x;
  var y;
  var stName;

  Location({this.x, this.y, this.stName});
  Future<void> getMyCurrentLocation() async
  {
    try {
      await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      y = position.latitude;
      x = position.longitude;
      print(position);
    } catch (e) {
      print("no");
    }
  }
}

Future<void> find(myDb) async {
  // Network net = Network("http://openapi.seoul.go.kr:8088/49647777496c656d39304a6d717744/json/subwayStationMaster/1/1000/");
  //
  // var parse = await net.getJsonData();
  // String rst = "[";
  //
  // for(var cur in parse["subwayStationMaster"]["row"])
  //   {
  //     if(cur["ROUTE"] == "분당선")
  //       {
  //         rst += "Location(x:" + cur["CRDNT_X"] + ', y:' +  cur["CRDNT_Y"] + ", stName : \"" + cur["STATN_NM"] + "\"),";
  //       }
  //     else if(cur["ROUTE"] == "수인선")
  //     {
  //       rst += "Location(x:" + cur["CRDNT_X"] + ', y:' +  cur["CRDNT_Y"] + ", stName : \"" + cur["STATN_NM"] + "\"),";
  //     }
  //     else if(cur["ROUTE"] == "안산선")
  //     {
  //       rst += "Location(x:" + cur["CRDNT_X"] + ', y:' +  cur["CRDNT_Y"] + ", stName : \"" + cur["STATN_NM"] + "\"),";
  //     }
  //   }
  // log(rst);
  List<Location> locData = [
    Location(x: 127.048807, y: 37.504856, stName: "선릉"),
    Location(x: 127.052873, y: 37.496237, stName: "한티"),
    Location(x: 127.055186, y: 37.491224, stName: "도곡"),
    Location(x: 127.058856, y: 37.486839, stName: "구룡"),
    Location(x: 127.06614, y: 37.489116, stName: "개포동"),
    Location(x: 127.07272, y: 37.491373, stName: "대모산입구"),
    Location(x: 127.101422, y: 37.487472, stName: "수서"),
    Location(x: 127.126658, y: 37.470345, stName: "복정"),
    Location(x: 126.85344, y: 37.309689, stName: "한대앞"),
    Location(x: 126.838573, y: 37.315941, stName: "중앙"),
    Location(x: 126.823144, y: 37.316784, stName: "고잔"),
    Location(x: 126.805913, y: 37.320646, stName: "초지"),
    Location(x: 126.788532, y: 37.327082, stName: "안산"),
    Location(x: 126.765844, y: 37.338212, stName: "신길온천"),
    Location(x: 126.742989, y: 37.351735, stName: "정왕"),
    Location(x: 126.738714, y: 37.362357, stName: "오이도"),
    Location(x: 126.925365, y: 37.349801, stName: "수리산"),
    Location(x: 126.999422, y: 37.265917, stName: "수원"),
    Location(x: 127.044707, y: 37.543617, stName: "서울숲"),
    Location(x: 127.040534, y: 37.527381, stName: "압구정로데오"),
    Location(x: 127.041151, y: 37.517469, stName: "강남구청"),
    Location(x: 127.043677, y: 37.510735, stName: "선정릉"),
    Location(x: 127.126697, y: 37.448605, stName: "가천대"),
    Location(x: 127.127709, y: 37.440019, stName: "태평"),
    Location(x: 127.129104, y: 37.432052, stName: "모란"),
    Location(x: 127.128715, y: 37.411185, stName: "야탑"),
    Location(x: 127.123592, y: 37.385126, stName: "서현"),
    Location(x: 127.114322, y: 37.378455, stName: "수내"),
    Location(x: 127.10807, y: 37.365994, stName: "정자"),
    Location(x: 127.10891, y: 37.350077, stName: "미금"),
    Location(x: 127.108942, y: 37.339824, stName: "오리"),
    Location(x: 127.128248, y: 37.395371, stName: "이매"),
    Location(x: 127.108196, y: 37.312752, stName: "보정"),
    Location(x: 127.107395, y: 37.324753, stName: "죽전"),
    Location(x: 127.105664, y: 37.298969, stName: "구성"),
    Location(x: 127.111313, y: 37.286102, stName: "신갈"),
    Location(x: 127.11591, y: 37.275061, stName: "기흥"),
    Location(x: 127.108847, y: 37.26181, stName: "상갈"),
    Location(x: 127.078934, y: 37.259489, stName: "청명"),
    Location(x: 127.071394, y: 37.251568, stName: "영통"),
    Location(x: 127.057353, y: 37.245795, stName: "망포"),
    Location(x: 127.040566, y: 37.252759, stName: "매탄권선"),
    Location(x: 127.030736, y: 37.261911, stName: "수원시청"),
    Location(x: 127.015678, y: 37.265481, stName: "매교"),
    Location(x: 126.980248, y: 37.24963, stName: "고색"),
    Location(x: 126.963676, y: 37.24304, stName: "오목천"),
    Location(x: 126.90879, y: 37.250102, stName: "어천"),
    Location(x: 126.879483, y: 37.264179, stName: "야목"),
    Location(x: 126.85685, y: 37.28998, stName: "사리"),
    Location(x: 126.745177, y: 37.379681, stName: "달월"),
    Location(x: 126.742699, y: 37.391769, stName: "월곶"),
    Location(x: 126.733522, y: 37.40095, stName: "소래포구"),
    Location(x: 126.722478, y: 37.400614, stName: "인천논현"),
    Location(x: 126.708627, y: 37.401637, stName: "호구포"),
    Location(x: 126.695216, y: 37.407722, stName: "남동인더스파크"),
    Location(x: 126.686648, y: 37.413049, stName: "원인재"),
    Location(x: 126.67894, y: 37.417804, stName: "연수"),
    Location(x: 126.657772, y: 37.428514, stName: "송도"),
    Location(x: 126.649619, y: 37.448493, stName: "인하대"),
    Location(x: 126.638297, y: 37.460789, stName: "숭의"),
    Location(x: 126.623853, y: 37.46874, stName: "신포"),
    Location(x: 127.044585, y: 37.579956, stName: "청량리"),
    Location(x: 126.617326, y: 37.476403, stName: "인천")
  ];
  Location curLoc = new Location();
  await curLoc.getMyCurrentLocation();
  // curLoc.x = 127.047803;
  // curLoc.y = 37.244389;
   curLoc.stName = "error";

  var min = 99.0;
  var temp;

  for (var cur in locData) {
    temp = sqrt(pow(curLoc.x - cur.x, 2) + pow(curLoc.y - cur.y, 2));
    if (min > temp) {
      min = temp;
      curLoc.stName = cur.stName;
    }
  }
  if(curLoc.stName != "error")
    {
      List<StationInform>  data =  mapData2List(await getAllStationName());
      int index = 0;
      for( ; index < data.length; index++)
        {
          if(data[index].kName == curLoc.stName)
            break;
        }
      if (verifySearchData(curLoc.stName, await myDb.getListFromDB())) {
        myDb.insert(UserData(id: int.parse(data[index].stCode.substring(1)), stName: curLoc.stName));
        // FavoritePageState? parent = context.findAncestorStateOfType<FavoritePageState>();
        showToast("주변역 ${curLoc.stName}역이\n추가되었습니다", true);
      } else
        showToast("주변역 ${curLoc.stName}역은\n이미 추가된 역입니다", true);
    }
  else
    {
      showToast("추가 실패", true);
    }
}
