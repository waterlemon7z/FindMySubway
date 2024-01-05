import 'package:find_my_subway/entity/UserSubwayDataEntity.dart';
import 'package:find_my_subway/repository/UserSubwayRepository.dart';

class UserSubwayService {
  final UserSubwayRepository _userSubwayRepository = UserSubwayRepository();

  Future<List<UserSubwayDataEntity>> getUserData() async {
    return await _userSubwayRepository.findAll();
  }

  void insert(UserSubwayDataEntity userSubwayDataEntity) {
    _userSubwayRepository.insertByData(userSubwayDataEntity);
  }

  void reset() {
    _userSubwayRepository.reset();
  }

  void delete(int id) {
    _userSubwayRepository.deleteById(id);
  }
}
