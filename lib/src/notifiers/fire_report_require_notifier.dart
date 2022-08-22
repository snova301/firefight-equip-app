import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/model/fire_report_require_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ガス警報器のProviderの定義
final fireReportRequireProvider =
    StateNotifierProvider<FireReportRequireNotifier, FireReportRequireClass>(
        (ref) {
  return FireReportRequireNotifier();
});

/// 配線リスト入力のNotifierの定義
class FireReportRequireNotifier extends StateNotifier<FireReportRequireClass> {
  // 空のデータとして初期化
  FireReportRequireNotifier()
      : super(FireReportRequireClass(
          firePreventProperty: FirePreventPropertyEnum.no1I,
          sq: 0,
          isDistance: false,
          isAlwaysReport: false,
          result: RequireSentenceEnum.none.title,
          reason: '',
        ));

  /// 防火対象物の更新
  void updateFirePreventProperty(FirePreventPropertyEnum newProperty) {
    state = state.copyWith(firePreventProperty: newProperty);
  }

  /// 延べ面積の更新
  void updateSq(String newVal) {
    try {
      state = state.copyWith(sq: int.parse(newVal));
    } catch (e) {
      state = state.copyWith(sq: 0);
    }
  }

  /// 消防機関から著しく離れた場所その他総務省令で定める場所の真偽値の更新
  void updateIsDistance(bool newBool) {
    state = state.copyWith(isDistance: newBool);
  }

  /// 消防機関へ常時通報することができる電話を設置の真偽値の更新
  void updateIsAlwaysReport(bool newBool) {
    state = state.copyWith(isAlwaysReport: newBool);
  }

  /// 計算実行
  /// 消防法施行令第23条より
  void run() {
    /// 読み込み
    final firePreventProperty = state.firePreventProperty;

    /// 入力条件をもとに判断
    if (
        // 消防機関から著しく離れた場所その他総務省令で定める場所は設置免除
        state.isDistance) {
      state = state.copyWith(result: RequireSentenceEnum.no.title);
    } else if (
        // 消防に常時通報できる電話を設置した場合は設置免除
        // ただし、5項イ、6項イ-ハは除く
        // 施行令23条 3項
        firePreventProperty != FirePreventPropertyEnum.no5I &&
            firePreventProperty != FirePreventPropertyEnum.no6I123 &&
            firePreventProperty != FirePreventPropertyEnum.no6I4 &&
            firePreventProperty != FirePreventPropertyEnum.no6Ro &&
            firePreventProperty != FirePreventPropertyEnum.no6Ha &&
            state.isAlwaysReport) {
      state = state.copyWith(result: RequireSentenceEnum.no.title);
    } else if (
        // 延べ面積に関係なく設置義務
        // 6項イ1-3、6項ロ、16の2項、16の3項
        // 施行令23条 1項 1号
        firePreventProperty == FirePreventPropertyEnum.no6I123 ||
            firePreventProperty == FirePreventPropertyEnum.no6Ro ||
            firePreventProperty == FirePreventPropertyEnum.no16No2 ||
            firePreventProperty == FirePreventPropertyEnum.no16No3) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
    } else if (
        // 延べ面積500m2以上で設置義務
        // 1項、2項、4項、5項イ、6項イ4、6項ハ、6項ニ、12項、17項
        // 施行令23条 1項 2号
        (firePreventProperty == FirePreventPropertyEnum.no1I ||
                firePreventProperty == FirePreventPropertyEnum.no1Ro ||
                firePreventProperty == FirePreventPropertyEnum.no2I ||
                firePreventProperty == FirePreventPropertyEnum.no2Ro ||
                firePreventProperty == FirePreventPropertyEnum.no2Ha ||
                firePreventProperty == FirePreventPropertyEnum.no2Ni ||
                firePreventProperty == FirePreventPropertyEnum.no4 ||
                firePreventProperty == FirePreventPropertyEnum.no5I ||
                firePreventProperty == FirePreventPropertyEnum.no6I4 ||
                firePreventProperty == FirePreventPropertyEnum.no6Ha ||
                firePreventProperty == FirePreventPropertyEnum.no6Ni ||
                firePreventProperty == FirePreventPropertyEnum.no12I ||
                firePreventProperty == FirePreventPropertyEnum.no12Ro ||
                firePreventProperty == FirePreventPropertyEnum.no17) &&
            state.sq >= 500) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
    } else if (
        // 延べ面積1000m2以上で設置義務
        // 3項、5項ロ、7項、8項、9項、10項、11項、13項、14項、15項
        // 施行令23条 1項 3号
        (firePreventProperty == FirePreventPropertyEnum.no3I ||
                firePreventProperty == FirePreventPropertyEnum.no3Ro ||
                firePreventProperty == FirePreventPropertyEnum.no5Ro ||
                firePreventProperty == FirePreventPropertyEnum.no7 ||
                firePreventProperty == FirePreventPropertyEnum.no8 ||
                firePreventProperty == FirePreventPropertyEnum.no9I ||
                firePreventProperty == FirePreventPropertyEnum.no9Ro ||
                firePreventProperty == FirePreventPropertyEnum.no10 ||
                firePreventProperty == FirePreventPropertyEnum.no11 ||
                firePreventProperty == FirePreventPropertyEnum.no13I ||
                firePreventProperty == FirePreventPropertyEnum.no13Ro ||
                firePreventProperty == FirePreventPropertyEnum.no14 ||
                firePreventProperty == FirePreventPropertyEnum.no15) &&
            state.sq >= 1000) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
    } else {
      state = state.copyWith(result: RequireSentenceEnum.no.title);
      // state = state.copyWith(reason: 'ただし、市町村条例には注意してください');
    }
  }
}

/// 延べ面積入力初期化
final fireReportReqSqTxtCtrlProvider = StateProvider((ref) {
  String sq = ref.watch(fireReportRequireProvider).sq.toString();
  return TextEditingController(text: sq);
});
