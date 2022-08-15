import 'dart:convert';
import 'package:firefight_equip/src/model/data_class.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// shared_pref用のenum
enum SharedPrefEnum {
  calcCableDesign,
  calcPower,
  calcConduit,
  calcWiringList,
  setting,
}

/// shared_preferencesのデータ読み込みや削除を行うクラス
class StateManagerClass {
  /// 以前の計算データをshared_preferencesから削除
  void removeCalc(WidgetRef ref) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    /// キャッシュ削除
    prefs.remove(SharedPrefEnum.calcCableDesign.name);

    /// providerの中身を削除
    // ref.read(cableDesignProvider.notifier).removeAll();
  }

  /// shared_preferencesの読込み
  void getPrefs(WidgetRef ref) async {
    /// 初期化
    SharedPreferences prefs = await SharedPreferences.getInstance();

    /// データ読み込み
    var getCableDesign = prefs.getString(SharedPrefEnum.calcCableDesign.name);
    var getElecPower = prefs.getString(SharedPrefEnum.calcPower.name);
    var getConduit = prefs.getString(SharedPrefEnum.calcConduit.name);
    var getWiringList = prefs.getString(SharedPrefEnum.calcWiringList.name);
    var getSetting = prefs.getString(SharedPrefEnum.setting.name);

    /// ケーブル設計
    /// データがない場合はnullになるので、null以外の場合でデコードする
    /// また、データクラスの変更があった場合は読み込みエラーになるので、回避
    try {
      /// jsonをデコード
      var getCableDesignData =
          CableDesignData.fromJson(jsonDecode(getCableDesign!));

      /// 値をproviderへ
      // ref.read(cableDesignProvider.notifier).updateAll(getCableDesignData);
    } catch (e) {
      print(e);
    }

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

/// shared_prefでケーブル設計データを非同期で保存するprovider
final cableDesignSPSetProvider = FutureProvider((ref) async {
  /// 初期化
  SharedPreferences prefs = await SharedPreferences.getInstance();

  ///  データの整形
  // var setCableDesign = jsonEncode(ref.watch(cableDesignProvider).toJson());

  ///  書込み
  // prefs.setString(SharedPrefEnum.calcCableDesign.name, setCableDesign);
});
