import 'dart:convert';
import 'package:firefight_equip/src/model/data_class.dart';
import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/notifiers/setting_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// shared_preferencesのデータ読み込みや削除を行うクラス
class SharedPrefClass {
  /// 以前の計算データをshared_preferencesから削除
  void removeCalc(WidgetRef ref) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    /// キャッシュ削除
    // prefs.remove(SharedPrefEnum.calcCableDesign.name);

    /// providerの中身を削除
    // ref.read(cableDesignProvider.notifier).removeAll();
  }

  /// shared_preferencesの読込み
  void getPrefs(WidgetRef ref) async {
    /// 初期化
    SharedPreferences prefs = await SharedPreferences.getInstance();

    /// データ読み込み
    var getSetting = prefs.getString(PageNameEnum.setting.name);

    /// 設定
    /// データがない場合、nullになるので、null以外の場合でデコードする
    /// また、データクラスの変更があった場合は読み込みエラーになるので、回避
    try {
      var getSettingData = SettingDataClass.fromJson(jsonDecode(getSetting!));

      /// 値をproviderへ
      ref
          .read(settingProvider.notifier)
          .updateDarkMode(getSettingData.darkMode);
    } catch (e) {
      print(e);
    }
  }
}

/// shared_prefで設定データを非同期で保存するprovider
final settingSPSetProvider = FutureProvider((ref) async {
  /// 初期化
  SharedPreferences prefs = await SharedPreferences.getInstance();

  ///  データの整形
  var setSetting = jsonEncode(ref.watch(settingProvider).toJson());

  ///  書込み
  prefs.setString(PageNameEnum.setting.name, setSetting);
});
