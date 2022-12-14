import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/model/fire_ext_require_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 消火器設置義務判定のProviderの定義
final fireExtRequireProvider =
    StateNotifierProvider<FireExtRequireNotifier, FireExtRequireClass>((ref) {
  return FireExtRequireNotifier();
});

/// 消火器設置義務判定のNotifierの定義
class FireExtRequireNotifier extends StateNotifier<FireExtRequireClass> {
  // 空のデータとして初期化
  FireExtRequireNotifier()
      : super(FireExtRequireClass(
          firePreventProperty: FirePreventPropertyEnum.no1I,
          sq: 0,
          sqFloor: 0,
          isNoWindow: false,
          isCombust: false,
          isUsedFire: false,
          result: RequireSentenceEnum.none.title,
          reason: RequireSentenceEnum.none.title,
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

  /// 無窓階真偽値の更新
  void updateIsNoWindow(bool newBool) {
    state = state.copyWith(isNoWindow: newBool);
  }

  /// 指定可燃物真偽値の更新
  void updateIsCombust(bool newBool) {
    state = state.copyWith(isCombust: newBool);
  }

  /// 火を使う器具真偽値の更新
  void updateIsUsedFire(bool newBool) {
    state = state.copyWith(isUsedFire: newBool);
  }

  /// 計算実行
  void run() {
    /// 読み込み
    final firePreventProperty = state.firePreventProperty;
    // final sq = state.sq;
    // final isNoWindow = state.isNoWindow;
    // final isCombust = state.isCombust;
    // final isUsedFire = state.isUsedFire;

    /// 入力条件をもとに判断
    if (
        // 延べ面積に関係なく設置義務がある防火対象物
        // 1項イ、2項、6項イ1-3、6項ロ、16の2項、16の3項、17項、20項
        // 施行令10条1項1号イ
        firePreventProperty == FirePreventPropertyEnum.no1I ||
            firePreventProperty == FirePreventPropertyEnum.no2I ||
            firePreventProperty == FirePreventPropertyEnum.no2Ro ||
            firePreventProperty == FirePreventPropertyEnum.no2Ha ||
            firePreventProperty == FirePreventPropertyEnum.no2Ni ||
            firePreventProperty == FirePreventPropertyEnum.no6I123 ||
            firePreventProperty == FirePreventPropertyEnum.no6Ro ||
            firePreventProperty == FirePreventPropertyEnum.no16No2 ||
            firePreventProperty == FirePreventPropertyEnum.no16No3 ||
            firePreventProperty == FirePreventPropertyEnum.no17 ||
            firePreventProperty == FirePreventPropertyEnum.no20) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
      state = state.copyWith(reason: '延べ面積に関係なく消火器具の設置が義務');
    } else if (
        // 延べ面積に関係なく設置義務がある防火対象物
        // 3項の火を使用する設備を使う場合
        // 施行令10条1項1号ロ
        (firePreventProperty == FirePreventPropertyEnum.no3I ||
                firePreventProperty == FirePreventPropertyEnum.no3Ro) &&
            state.isUsedFire) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
      state = state.copyWith(reason: '火を使用する器具が設置されているため、延べ面積に関係なく消火器具の設置が義務');
    } else if (
        // 延べ面積150m2以上で設置義務がある防火対象物
        // 1項ロ、4項、5項、6項イ4、6項ハ、6項ニ、9項、12項、13項、14項
        // 施行令10条1項2号イ
        (firePreventProperty == FirePreventPropertyEnum.no1Ro ||
                firePreventProperty == FirePreventPropertyEnum.no4 ||
                firePreventProperty == FirePreventPropertyEnum.no5I ||
                firePreventProperty == FirePreventPropertyEnum.no5Ro ||
                firePreventProperty == FirePreventPropertyEnum.no6I4 ||
                firePreventProperty == FirePreventPropertyEnum.no6Ha ||
                firePreventProperty == FirePreventPropertyEnum.no6Ni ||
                firePreventProperty == FirePreventPropertyEnum.no9I ||
                firePreventProperty == FirePreventPropertyEnum.no9Ro ||
                firePreventProperty == FirePreventPropertyEnum.no12I ||
                firePreventProperty == FirePreventPropertyEnum.no12Ro ||
                firePreventProperty == FirePreventPropertyEnum.no13I ||
                firePreventProperty == FirePreventPropertyEnum.no13Ro ||
                firePreventProperty == FirePreventPropertyEnum.no14) &&
            state.sq >= 150) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
      state = state.copyWith(reason: '延べ面積150m2以上で消火器具の設置が義務');
    } else if (
        // 延べ面積150m2以上で設置義務がある防火対象物
        // 3項の火を使用する設備を使わない場合
        // 施行令10条1項2号ロ
        (firePreventProperty == FirePreventPropertyEnum.no3I ||
                firePreventProperty == FirePreventPropertyEnum.no3Ro) &&
            !state.isUsedFire &&
            state.sq >= 150) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
      state =
          state.copyWith(reason: '火を使用する器具が設置されていないため、延べ面積150m2以上で消火器具の設置が義務');
    } else if (
        // 延べ面積300m2以上で設置義務がある防火対象物
        // 7項、8項、10項、11項、15項
        // 施行令10条1項3号
        (firePreventProperty == FirePreventPropertyEnum.no7 ||
                firePreventProperty == FirePreventPropertyEnum.no8 ||
                firePreventProperty == FirePreventPropertyEnum.no10 ||
                firePreventProperty == FirePreventPropertyEnum.no11 ||
                firePreventProperty == FirePreventPropertyEnum.no15) &&
            state.sq >= 300) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
      state = state.copyWith(reason: '延べ面積300m2以上で消火器具の設置が義務');
    } else if (
        // 延べ面積に関係なく設置義務がある防火対象物
        // 少量危険物、指定可燃物
        // 施行令10条1項4号
        state.isCombust) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
      state = state.copyWith(reason: '少量危険物または指定可燃物を貯蔵または取り扱っているため');
    } else if (
        // 床面積50m2以上で設置義務がある防火対象物
        // 地階、無窓階、3F以上の階
        // 施行令10条1項5号
        state.isNoWindow && state.sqFloor >= 50) {
      state = state.copyWith(result: RequireSentenceEnum.yes.title);
      state = state.copyWith(reason: '地階、無窓階、3F以上の階は床面積が50m2以上で消火器具の設置が義務');
    } else {
      state = state.copyWith(result: RequireSentenceEnum.no.title);
      state = state.copyWith(reason: RequireSentenceEnum.reasonProviso.title);
    }
  }
}

/// 延べ面積入力初期化
final fireExtReqSqTxtCtrlProvider = StateProvider((ref) {
  String sq = ref.watch(fireExtRequireProvider).sq.toString();
  return TextEditingController(text: sq);
});

/// 床面積入力初期化
final fireExtReqSqFloorTxtCtrlProvider = StateProvider((ref) {
  String sq = ref.watch(fireExtRequireProvider).sqFloor.toString();
  return TextEditingController(text: sq);
});
