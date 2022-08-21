import 'dart:convert';
import 'package:firefight_equip/src/model/catalog_list_model.dart';
import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/model/fire_alarm_require_model.dart';
import 'package:firefight_equip/src/model/fire_ext_capacity_model.dart';
import 'package:firefight_equip/src/model/fire_ext_require_model.dart';
import 'package:firefight_equip/src/model/fire_report_require_model.dart';
import 'package:firefight_equip/src/model/gas_alarm_require_model.dart';
import 'package:firefight_equip/src/model/leakage_alarm_require_model.dart';
import 'package:firefight_equip/src/model/setting_model.dart';
import 'package:firefight_equip/src/notifiers/catalog_list_notifier.dart';
import 'package:firefight_equip/src/notifiers/fire_alarm_require_notifier.dart';
import 'package:firefight_equip/src/notifiers/fire_ext_capacity_notifier.dart';
import 'package:firefight_equip/src/notifiers/fire_ext_require_notifier.dart';
import 'package:firefight_equip/src/notifiers/fire_report_require_notifier.dart';
import 'package:firefight_equip/src/notifiers/gas_alarm_require_notifier.dart';
import 'package:firefight_equip/src/notifiers/leakage_alarm_require_notifier.dart';
import 'package:firefight_equip/src/notifiers/setting_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// shared_preferencesのデータ読み込みや削除を行うクラス
class SharedPrefClass {
  /// 以前の計算データをshared_preferencesから削除
  void removeCalc(WidgetRef ref) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    /// キャッシュ削除
    // prefs.remove(SharedPrefEnum.calcCableDesign.name);

    /// providerの中身を削除
    // ref.read(cableDesignProvider.notifier).removeAll();
  }

  /// shared_preferencesの読込み
  void getPrefs(WidgetRef ref) async {
    /// 初期化
    SharedPreferences prefs = await SharedPreferences.getInstance();

    /// ここから先、shared_preferenceから読み込むためのメソッド
    /// データがない場合、nullになるので、null以外の場合でデコードする
    /// また、データクラスの変更があった場合は読み込みエラーになるので、回避
    getPrefSetting(ref, prefs);
    getPrefFireExtRequire(ref, prefs);
    getPrefFireExtCapacity(ref, prefs);
    getPrefFireAlarmRequire(ref, prefs);
    getPrefFireReportRequire(ref, prefs);
    getPrefGasAlarmRequire(ref, prefs);
    getPrefleakageAlarmRequire(ref, prefs);
    getPrefCatalogList(ref, prefs);
  }

  /// 設定
  void getPrefSetting(WidgetRef ref, SharedPreferences prefs) {
    var getSetting = prefs.getString(PageNameEnum.setting.name);
    if (getSetting != null) {
      var getSettingData = SettingDataClass.fromJson(jsonDecode(getSetting));
      try {
        /// 値をproviderへ
        ref
            .read(settingProvider.notifier)
            .updateDarkMode(getSettingData.darkMode);
      } catch (e) {
        // print(e);
      }
    }
  }

  /// fireExtRequire
  void getPrefFireExtRequire(WidgetRef ref, SharedPreferences prefs) {
    var getFireExtRequire = prefs.getString(PageNameEnum.fireExtRequire.name);
    if (getFireExtRequire != null) {
      var getFireExtRequireData =
          FireExtRequireClass.fromJson(jsonDecode(getFireExtRequire));
      try {
        /// 値をproviderへ
        ref.read(fireExtRequireProvider.notifier).updateFirePreventProperty(
            getFireExtRequireData.firePreventProperty);
        ref
            .read(fireExtRequireProvider.notifier)
            .updateSq(getFireExtRequireData.sq.toString());
        ref
            .read(fireExtRequireProvider.notifier)
            .updateIsNoWindow(getFireExtRequireData.isNoWindow);
        ref
            .read(fireExtRequireProvider.notifier)
            .updateIsCombust(getFireExtRequireData.isCombust);
        ref
            .read(fireExtRequireProvider.notifier)
            .updateIsUsedFire(getFireExtRequireData.isUsedFire);
      } catch (e) {
        // print(e);
      }
    }
  }

  /// fireExtCapacity
  void getPrefFireExtCapacity(WidgetRef ref, SharedPreferences prefs) {
    var getFireExtCapacity = prefs.getString(PageNameEnum.fireExtCapacity.name);
    if (getFireExtCapacity != null) {
      var getFireExtCapacityData =
          FireExtCapacityClass.fromJson(jsonDecode(getFireExtCapacity));
      try {
        /// 値をproviderへ
        ref.read(fireExtCapacityProvider.notifier).updateFirePreventProperty(
            getFireExtCapacityData.firePreventProperty);
        ref
            .read(fireExtCapacityProvider.notifier)
            .updateSq(getFireExtCapacityData.sq.toString());
        ref.read(fireExtCapacityProvider.notifier).updateSqElectrocity(
            getFireExtCapacityData.sqElectrocity.toString());
        ref
            .read(fireExtCapacityProvider.notifier)
            .updateSqBoiler(getFireExtCapacityData.sqBoiler.toString());
        ref
            .read(fireExtCapacityProvider.notifier)
            .updateIsFireproof(getFireExtCapacityData.isFireproof);
        ref
            .read(fireExtCapacityProvider.notifier)
            .updateIsCombust(getFireExtCapacityData.isCombust);
      } catch (e) {
        // print(e);
      }
    }
  }

  /// fireAlarmRequire
  void getPrefFireAlarmRequire(WidgetRef ref, SharedPreferences prefs) {
    var getFireAlarmRequire =
        prefs.getString(PageNameEnum.fireAlarmRequire.name);
    if (getFireAlarmRequire != null) {
      var getFireAlarmRequireData =
          FireAlarmRequireClass.fromJson(jsonDecode(getFireAlarmRequire));
      try {
        /// 値をproviderへ
        ref.read(fireAlarmRequireProvider.notifier).updateFirePreventProperty(
            getFireAlarmRequireData.firePreventProperty);
        ref
            .read(fireAlarmRequireProvider.notifier)
            .updateSq(getFireAlarmRequireData.sq.toString());
        ref
            .read(fireAlarmRequireProvider.notifier)
            .updateSqFloor(getFireAlarmRequireData.sqFloor.toString());
        ref
            .read(fireAlarmRequireProvider.notifier)
            .updateIsNoWindow(getFireAlarmRequireData.isNoWindow);
        ref
            .read(fireAlarmRequireProvider.notifier)
            .updateIsCombust(getFireAlarmRequireData.isCombust);
        ref
            .read(fireAlarmRequireProvider.notifier)
            .updateIsLodge(getFireAlarmRequireData.isLodge);
        ref
            .read(fireAlarmRequireProvider.notifier)
            .updateIsSprinkler(getFireAlarmRequireData.isSprinkler);
        ref
            .read(fireAlarmRequireProvider.notifier)
            .updateIsOneStairs(getFireAlarmRequireData.isOneStairs);
        ref
            .read(fireAlarmRequireProvider.notifier)
            .updateFloor(getFireAlarmRequireData.floor);
        ref
            .read(fireAlarmRequireProvider.notifier)
            .updateUsedType(getFireAlarmRequireData.usedType);
      } catch (e) {
        // print(e);
      }
    }
  }

  /// fireReportRequire
  void getPrefFireReportRequire(WidgetRef ref, SharedPreferences prefs) {
    var getFireReportRequire =
        prefs.getString(PageNameEnum.fireReportRequire.name);
    if (getFireReportRequire != null) {
      var getFireReportRequireData =
          FireReportRequireClass.fromJson(jsonDecode(getFireReportRequire));
      try {
        /// 値をproviderへ
        ref.read(fireReportRequireProvider.notifier).updateFirePreventProperty(
            getFireReportRequireData.firePreventProperty);
        ref
            .read(fireReportRequireProvider.notifier)
            .updateSq(getFireReportRequireData.sq.toString());
        ref
            .read(fireReportRequireProvider.notifier)
            .updateIsDistance(getFireReportRequireData.isDistance);
        ref
            .read(fireReportRequireProvider.notifier)
            .updateIsAlwaysReport(getFireReportRequireData.isAlwaysReport);
      } catch (e) {
        // print(e);
      }
    }
  }

  /// fireReportRequire
  void getPrefGasAlarmRequire(WidgetRef ref, SharedPreferences prefs) {
    var getGasAlarmRequire = prefs.getString(PageNameEnum.gasAlarmRequire.name);
    if (getGasAlarmRequire != null) {
      var getGasAlarmRequireData =
          GasAlarmRequireClass.fromJson(jsonDecode(getGasAlarmRequire));
      try {
        /// 値をproviderへ
        ref.read(gasAlarmRequireProvider.notifier).updateFirePreventProperty(
            getGasAlarmRequireData.firePreventProperty);
        ref
            .read(gasAlarmRequireProvider.notifier)
            .updateSq(getGasAlarmRequireData.sq.toString());
        ref
            .read(gasAlarmRequireProvider.notifier)
            .updateSqFloor(getGasAlarmRequireData.sqFloor.toString());
        ref
            .read(gasAlarmRequireProvider.notifier)
            .updateIsHotSpring(getGasAlarmRequireData.isHotSpring);
        ref
            .read(gasAlarmRequireProvider.notifier)
            .updateIsUnderGround(getGasAlarmRequireData.isUnderGround);
      } catch (e) {
        // print(e);
      }
    }
  }

  /// leakageAlarmRequire
  void getPrefleakageAlarmRequire(WidgetRef ref, SharedPreferences prefs) {
    var getLeakageAlarmRequire =
        prefs.getString(PageNameEnum.leakageAlarmRequire.name);
    if (getLeakageAlarmRequire != null) {
      var getLeakageAlarmRequireData =
          LeakageAlarmRequireClass.fromJson(jsonDecode(getLeakageAlarmRequire));
      try {
        /// 値をproviderへ
        ref
            .read(leakageAlarmRequireProvider.notifier)
            .updateFirePreventProperty(
                getLeakageAlarmRequireData.firePreventProperty);
        ref
            .read(leakageAlarmRequireProvider.notifier)
            .updateSq(getLeakageAlarmRequireData.sq.toString());
        ref
            .read(leakageAlarmRequireProvider.notifier)
            .updateSqFloor(getLeakageAlarmRequireData.sqFloor.toString());
        ref.read(leakageAlarmRequireProvider.notifier).updateIsContractCurrent(
            getLeakageAlarmRequireData.isContractCurrent);
      } catch (e) {
        // print(e);
      }
    }
  }

  /// catalogList
  void getPrefCatalogList(WidgetRef ref, SharedPreferences prefs) {
    var getCatalogList = prefs.getStringList(PageNameEnum.catalogList.name);
    if (getCatalogList != null) {
      var getCatalogListData = getCatalogList
          .map((e) => CatalogListClass.fromJson(jsonDecode(e)))
          .toList();
      try {
        /// 値をproviderへ
        ref
            .read(catalogListProvider.notifier)
            .updateCatalog(getCatalogListData);
      } catch (e) {
        // print(e);
      }
    }
  }
}

///
///
/// ここから先はshared_preferenceに保存するためのprovider
/// デーラは非同期で保存するため、FutureProviderを使う
///
///

/// shared_prefで設定データを非同期で保存するprovider
final settingSPSetProvider = FutureProvider((ref) async {
  /// 初期化
  SharedPreferences prefs = await SharedPreferences.getInstance();

  ///  データの整形
  var setSetting = jsonEncode(ref.watch(settingProvider).toJson());

  ///  書込み
  prefs.setString(PageNameEnum.setting.name, setSetting);
});

/// shared_prefで設定データを非同期で保存するprovider
final fireExtRequireSPSetProvider = FutureProvider((ref) async {
  /// 初期化
  SharedPreferences prefs = await SharedPreferences.getInstance();

  ///  データの整形
  var json = jsonEncode(ref.watch(fireExtRequireProvider).toJson());

  ///  書込み
  prefs.setString(PageNameEnum.fireExtRequire.name, json);
});

/// shared_prefで設定データを非同期で保存するprovider
final fireExtCapacitySPSetProvider = FutureProvider((ref) async {
  /// 初期化
  SharedPreferences prefs = await SharedPreferences.getInstance();

  ///  データの整形
  var json = jsonEncode(ref.watch(fireExtCapacityProvider).toJson());

  ///  書込み
  prefs.setString(PageNameEnum.fireExtCapacity.name, json);
});

/// shared_prefで設定データを非同期で保存するprovider
final fireAlarmRequireSPSetProvider = FutureProvider((ref) async {
  /// 初期化
  SharedPreferences prefs = await SharedPreferences.getInstance();

  ///  データの整形
  var json = jsonEncode(ref.watch(fireAlarmRequireProvider).toJson());

  ///  書込み
  prefs.setString(PageNameEnum.fireAlarmRequire.name, json);
});

/// shared_prefで設定データを非同期で保存するprovider
final fireReportRequireSPSetProvider = FutureProvider((ref) async {
  /// 初期化
  SharedPreferences prefs = await SharedPreferences.getInstance();

  ///  データの整形
  var json = jsonEncode(ref.watch(fireReportRequireProvider).toJson());

  ///  書込み
  prefs.setString(PageNameEnum.fireReportRequire.name, json);
});

/// shared_prefで設定データを非同期で保存するprovider
final gasAlarmRequireSPSetProvider = FutureProvider((ref) async {
  /// 初期化
  SharedPreferences prefs = await SharedPreferences.getInstance();

  ///  データの整形
  var json = jsonEncode(ref.watch(gasAlarmRequireProvider).toJson());

  ///  書込み
  prefs.setString(PageNameEnum.gasAlarmRequire.name, json);
});

/// shared_prefで設定データを非同期で保存するprovider
final leakageAlarmRequireSPSetProvider = FutureProvider((ref) async {
  /// 初期化
  SharedPreferences prefs = await SharedPreferences.getInstance();

  ///  データの整形
  var json = jsonEncode(ref.watch(leakageAlarmRequireProvider).toJson());

  ///  書込み
  prefs.setString(PageNameEnum.leakageAlarmRequire.name, json);
});

/// shared_prefで設定データを非同期で保存するprovider
final catalogListSPSetProvider = FutureProvider((ref) async {
  /// 初期化
  SharedPreferences prefs = await SharedPreferences.getInstance();

  /// データの整形
  List<String> json = ref
      .watch(catalogListProvider)
      .map(((e) => jsonEncode(e.toJson())))
      .toList();

  /// 書込み
  prefs.setStringList(PageNameEnum.catalogList.name, json);
});
