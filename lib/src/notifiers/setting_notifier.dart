import 'package:firefight_equip/src/model/setting_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 設定のProviderの定義
final settingProvider =
    StateNotifierProvider<SettingProviderNotifier, SettingDataClass>((ref) {
  return SettingProviderNotifier();
});

/// 設定のStateNotifierを定義
class SettingProviderNotifier extends StateNotifier<SettingDataClass> {
  // 空のデータとして初期化
  SettingProviderNotifier() : super(const SettingDataClass(darkMode: false));

  void updateDarkMode(bool value) {
    state = state.copyWith(darkMode: value);
  }
}
