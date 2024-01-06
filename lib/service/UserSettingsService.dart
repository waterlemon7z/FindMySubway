import 'package:find_my_subway/entity/UserSettingsEntity.dart';
import 'package:find_my_subway/repository/UserSettingsRepository.dart';

class UserSettingsService
{
  final UserSettingsRepository _userSettingsRepository = UserSettingsRepository();
  UserSettingsEntity getSettingData()
  {
    return  _userSettingsRepository.findAll();
  }
  void updateSettingData(UserSettingsEntity entity)
  {
    _userSettingsRepository.update(entity);
  }
  void updateTheme(int themeCode)
  {
    UserSettingsEntity settingData = getSettingData();
    settingData.theme = themeCode;
    updateSettingData(settingData);
  }
  void updateLocation()
  {
    UserSettingsEntity settingData = getSettingData();
    settingData.location = !settingData.location;
    updateSettingData(settingData);
  }
  void updateAutoTimer()
  {
    UserSettingsEntity settingData = getSettingData();
    settingData.autoTimer = !settingData.autoTimer;
    updateSettingData(settingData);
  }
  Future<void> setHive() async
  {
    if(!_userSettingsRepository.isContains())
    {
      await _userSettingsRepository.update(UserSettingsEntity(0, true, "-1", 01, false, [], true));
    }
  }
}