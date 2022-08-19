import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/model/leakage_alarm_require_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ガス警報器のProviderの定義
final leakageAlarmRequireProvider = StateNotifierProvider<
    LeakageAlarmRequireNotifier, LeakageAlarmRequireClass>((ref) {
  return LeakageAlarmRequireNotifier();
});

/// 配線リスト入力のNotifierの定義
class LeakageAlarmRequireNotifier
    extends StateNotifier<LeakageAlarmRequireClass> {
  // 空のデータとして初期化
  LeakageAlarmRequireNotifier()
      : super(const LeakageAlarmRequireClass(
          firePreventProperty: FirePreventPropertyEnum.no1I,
          sq: 0,
          sqFloor: 0,
          isContractCurrent: false,
          result: '',
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

  /// 床面積の更新
  void updateSqFloor(String newVal) {
    try {
      state = state.copyWith(sqFloor: int.parse(newVal));
    } catch (e) {
      state = state.copyWith(sqFloor: 0);
    }
  }

  /// 契約電流50A以上の真偽値の更新
  void updateIsContractCurrent(bool newBool) {
    state = state.copyWith(isContractCurrent: newBool);
  }

  /// 計算実行
  /// 消防法施行令第22条より
  void run() {
    /// 読み込み
    final firePreventProperty = state.firePreventProperty;

    /// 入力条件をもとに判断
    if (
        // 延べ面積に関係なく設置義務
        // 17項
        // 施行令22条 1項
        firePreventProperty == FirePreventPropertyEnum.no17) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
    } else if (
        // 延べ面積が150m2以上で設置義務
        // 5項、9項
        // 施行令22条の2 2項
        (firePreventProperty == FirePreventPropertyEnum.no5I ||
                firePreventProperty == FirePreventPropertyEnum.no5Ro ||
                firePreventProperty == FirePreventPropertyEnum.no9I ||
                firePreventProperty == FirePreventPropertyEnum.no9Ro) &&
            state.sq >= 150) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
    } else if (
        // 延べ面積が300m2以上で設置義務
        // 1-4項、6項、12項、16の2項
        // 施行令22条の2 3項
        (firePreventProperty == FirePreventPropertyEnum.no1I ||
                firePreventProperty == FirePreventPropertyEnum.no1Ro ||
                firePreventProperty == FirePreventPropertyEnum.no2I ||
                firePreventProperty == FirePreventPropertyEnum.no2Ro ||
                firePreventProperty == FirePreventPropertyEnum.no2Ha ||
                firePreventProperty == FirePreventPropertyEnum.no2Ni ||
                firePreventProperty == FirePreventPropertyEnum.no3I ||
                firePreventProperty == FirePreventPropertyEnum.no3Ro ||
                firePreventProperty == FirePreventPropertyEnum.no4 ||
                firePreventProperty == FirePreventPropertyEnum.no6I123 ||
                firePreventProperty == FirePreventPropertyEnum.no6I4 ||
                firePreventProperty == FirePreventPropertyEnum.no6Ro ||
                firePreventProperty == FirePreventPropertyEnum.no6Ha ||
                firePreventProperty == FirePreventPropertyEnum.no6Ni ||
                firePreventProperty == FirePreventPropertyEnum.no12I ||
                firePreventProperty == FirePreventPropertyEnum.no12Ro ||
                firePreventProperty == FirePreventPropertyEnum.no16No2) &&
            state.sq >= 300) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
    } else if (
        // 延べ面積が500m2以上で設置義務
        // 7項、8項、10項、11項
        // 施行令22条の2 4項
        (firePreventProperty == FirePreventPropertyEnum.no7 ||
                firePreventProperty == FirePreventPropertyEnum.no8 ||
                firePreventProperty == FirePreventPropertyEnum.no10 ||
                firePreventProperty == FirePreventPropertyEnum.no11) &&
            state.sq >= 500) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
    } else if (
        // 延べ面積が1000m2以上で設置義務
        // 14項、15項
        // 施行令22条の2 5項
        (firePreventProperty == FirePreventPropertyEnum.no14 ||
                firePreventProperty == FirePreventPropertyEnum.no15) &&
            state.sq >= 1000) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
    } else if (
        // 延べ面積が500m2以上で、特定用途の床面積300m2以上で設置義務
        // 16項イ
        // 施行令22条の2 6項
        firePreventProperty == FirePreventPropertyEnum.no16I &&
            state.sq >= 500 &&
            state.sqFloor >= 300) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
    } else if (
        // 最大契約電流が50A以上で設置義務
        // 1-6項、15項、16項
        // 施行令22条の2 7項
        (firePreventProperty == FirePreventPropertyEnum.no1I ||
                firePreventProperty == FirePreventPropertyEnum.no1Ro ||
                firePreventProperty == FirePreventPropertyEnum.no2I ||
                firePreventProperty == FirePreventPropertyEnum.no2Ro ||
                firePreventProperty == FirePreventPropertyEnum.no2Ha ||
                firePreventProperty == FirePreventPropertyEnum.no2Ni ||
                firePreventProperty == FirePreventPropertyEnum.no3I ||
                firePreventProperty == FirePreventPropertyEnum.no3Ro ||
                firePreventProperty == FirePreventPropertyEnum.no4 ||
                firePreventProperty == FirePreventPropertyEnum.no5I ||
                firePreventProperty == FirePreventPropertyEnum.no5Ro ||
                firePreventProperty == FirePreventPropertyEnum.no6I123 ||
                firePreventProperty == FirePreventPropertyEnum.no6I4 ||
                firePreventProperty == FirePreventPropertyEnum.no6Ro ||
                firePreventProperty == FirePreventPropertyEnum.no6Ha ||
                firePreventProperty == FirePreventPropertyEnum.no6Ni ||
                firePreventProperty == FirePreventPropertyEnum.no15 ||
                firePreventProperty == FirePreventPropertyEnum.no16I ||
                firePreventProperty == FirePreventPropertyEnum.no16Ro ||
                firePreventProperty == FirePreventPropertyEnum.no16No2 ||
                firePreventProperty == FirePreventPropertyEnum.no16No3) &&
            state.isContractCurrent) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
    } else {
      state = state.copyWith(result: RequireSentenceEnum.no.title);
      state = state.copyWith(reason: 'ただし、市町村条例には注意してください');
    }
  }
}

/// 延べ面積入力初期化
final leakageAlarmReqSqTxtCtrlProvider = StateProvider((ref) {
  String sq = ref.watch(leakageAlarmRequireProvider).sq.toString();
  return TextEditingController(text: sq);
});

/// 床面積入力初期化
final leakageAlarmReqSqFloorTxtCtrlProvider = StateProvider((ref) {
  String sqFloor = ref.watch(leakageAlarmRequireProvider).sqFloor.toString();
  return TextEditingController(text: sqFloor);
});
