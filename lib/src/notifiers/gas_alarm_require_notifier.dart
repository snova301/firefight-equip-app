import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/model/gas_alarm_require_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ガス警報器のProviderの定義
final gasAlarmRequireProvider =
    StateNotifierProvider<GasAlarmRequireNotifier, GasAlarmRequireClass>((ref) {
  return GasAlarmRequireNotifier();
});

/// 配線リスト入力のNotifierの定義
class GasAlarmRequireNotifier extends StateNotifier<GasAlarmRequireClass> {
  // 空のデータとして初期化
  GasAlarmRequireNotifier()
      : super(GasAlarmRequireClass(
          firePreventProperty: FirePreventPropertyEnum.no1I,
          sq: 0,
          sqFloor: 0,
          isHotSpring: false,
          isUnderGround: false,
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

  /// 床面積の更新
  void updateSqFloor(String newVal) {
    try {
      state = state.copyWith(sqFloor: int.parse(newVal));
    } catch (e) {
      state = state.copyWith(sqFloor: 0);
    }
  }

  /// 温泉施設の真偽値の更新
  void updateIsHotSpring(bool newBool) {
    state = state.copyWith(isHotSpring: newBool);
  }

  /// 地階の真偽値の更新
  void updateIsUnderGround(bool newBool) {
    state = state.copyWith(isUnderGround: newBool);
  }

  /// 計算実行
  /// 消防法施行令第21条より
  void run() {
    /// 読み込み
    final firePreventProperty = state.firePreventProperty;

    /// 入力条件をもとに判断
    if (
        // 16の2項の防火対象物で、延べ面積が1000m2以上
        // 施行令21条の2 1項
        firePreventProperty == FirePreventPropertyEnum.no16No2 &&
            state.sq >= 1000) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
    } else if (
        // 16の3項の防火対象物で、延べ面積が1000m2以上、かつ特定用途の床面積が500m2以上
        // 施行令21条の2 2項
        firePreventProperty == FirePreventPropertyEnum.no16No3 &&
            state.sq >= 1000 &&
            state.sqFloor >= 500) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
    } else if (
        // 温泉の採取のための設備で総務省令で定めるものが設置
        // 施行令21条の2 3項
        state.isHotSpring) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
    } else if (
        // 特定防火対象物の地階で、床面積が1000m2以上
        // 施行令21条の2 4項
        firePreventProperty.isSpecific &&
            state.isUnderGround &&
            state.sqFloor >= 1000) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
    } else if (
        // 16項イの防火対象物の地階で、延べ面積が1000m2以上、かつ特定用途の床面積が500m2以上
        // 施行令21条の2 5項
        firePreventProperty == FirePreventPropertyEnum.no16I &&
            state.isUnderGround &&
            state.sq >= 1000 &&
            state.sqFloor >= 500) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
    } else {
      state = state.copyWith(result: RequireSentenceEnum.no.title);
      // state = state.copyWith(reason: 'ただし、市町村条例には注意してください');
    }
  }
}

/// 延べ面積入力初期化
final gasAlarmReqSqTxtCtrlProvider = StateProvider((ref) {
  String sq = ref.watch(gasAlarmRequireProvider).sq.toString();
  return TextEditingController(text: sq);
});

/// 床面積入力初期化
final gasAlarmReqSqFloorTxtCtrlProvider = StateProvider((ref) {
  String sqFloor = ref.watch(gasAlarmRequireProvider).sqFloor.toString();
  return TextEditingController(text: sqFloor);
});
