import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/model/fire_alarm_require_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 配線リスト入力のProviderの定義
final fireAlarmRequireProvider =
    StateNotifierProvider<FireAlarmRequireNotifier, FireAlarmRequireClass>(
        (ref) {
  return FireAlarmRequireNotifier();
});

/// 配線リスト入力のNotifierの定義
class FireAlarmRequireNotifier extends StateNotifier<FireAlarmRequireClass> {
  // 空のデータとして初期化
  FireAlarmRequireNotifier()
      : super(const FireAlarmRequireClass(
          firePreventProperty: FirePreventPropertyEnum.no1I,
          sq: 0,
          isNoWindow: false,
          isLodge: false,
          isCombust: false,
          floor: '1',
          result: '',
          reason: '',
        ));

  /// 防火対象物の更新
  void updateFirePreventProperty(FirePreventPropertyEnum newProperty) {
    state = state.copyWith(firePreventProperty: newProperty);
  }

  /// 面積の更新
  void updateSq(String newVal) {
    try {
      state = state.copyWith(sq: int.parse(newVal));
    } catch (e) {
      state = state.copyWith(sq: 0);
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

  /// 計算実行
  void run() {
    /// 読み込み
    final firePreventProperty = state.firePreventProperty;
    final sq = state.sq;
    final isNoWindow = state.isNoWindow;
    final isCombust = state.isCombust;

    /// 入力条件をもとに判断
    if (
        // 延べ面積に関係なく設置義務がある防火対象物
        // 1項イ、2項、6項イ1-3、6項ロ、16の2項、16の3項、17項、20項
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
      state = state.copyWith(result: '設置義務があります');
      state = state.copyWith(reason: '※ 延べ面積に関係なく消火器具の設置が義務');
    } else if (
        // 延べ面積に関係なく設置義務がある防火対象物
        // 3項の火を使用する設備を使う場合
        (firePreventProperty == FirePreventPropertyEnum.no3I ||
            firePreventProperty == FirePreventPropertyEnum.no3Ro)) {
      state = state.copyWith(result: '設置義務があります');
      state =
          state.copyWith(reason: '※ 火を使用する器具が設置されているため、延べ面積に関係なく消火器具の設置が義務');
    } else if (
        // 延べ面積に関係なく設置義務がある防火対象物
        // 少量危険物、指定可燃物
        isCombust) {
      state = state.copyWith(result: '設置義務があります');
      state = state.copyWith(reason: '※ 少量危険物または指定可燃物を貯蔵または取り扱っているため');
    } else if (
        // 延べ面積150m2以上で設置義務がある防火対象物
        // 1項ロ、4項、5項、6項イ4、6項ハ、6項ニ、9項、12項、13項、14項
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
            sq >= 150) {
      state = state.copyWith(result: '設置義務があります');
      state = state.copyWith(reason: '※ 延べ面積150m2以上で消火器具の設置が義務');
    } else if (
        // 延べ面積150m2以上で設置義務がある防火対象物
        // 3項の火を使用する設備を使わない場合
        (firePreventProperty == FirePreventPropertyEnum.no3I ||
            firePreventProperty == FirePreventPropertyEnum.no3Ro)) {
      state = state.copyWith(result: '設置義務があります');
      state =
          state.copyWith(reason: '※ 火を使用する器具が設置されているため、延べ面積150m2以上で消火器具の設置が義務');
    } else if (
        // 延べ面積300m2以上で設置義務がある防火対象物
        // 7項、8項、10項、11項、15項
        (firePreventProperty == FirePreventPropertyEnum.no7 ||
                firePreventProperty == FirePreventPropertyEnum.no8 ||
                firePreventProperty == FirePreventPropertyEnum.no10 ||
                firePreventProperty == FirePreventPropertyEnum.no11 ||
                firePreventProperty == FirePreventPropertyEnum.no15) &&
            sq >= 300) {
      state = state.copyWith(result: '設置義務があります');
      state = state.copyWith(reason: '※ 延べ面積300m2以上で消火器具の設置が義務');
    } else if (
        // 床面積50m2以上で設置義務がある防火対象物
        // 地階、無窓階、3F以上の階
        isNoWindow && sq >= 50) {
      state = state.copyWith(result: '設置義務があります');
      state = state.copyWith(reason: '※ 地階、無窓階、3F以上の階は床面積が50m2以上で消火器具の設置が義務');
    } else if (
        // 複合用途防火対象物は当該用途の基準による
        firePreventProperty == FirePreventPropertyEnum.no16I ||
            firePreventProperty == FirePreventPropertyEnum.no16Ro) {
      state = state.copyWith(result: '設置義務は当該用途の基準による');
      state = state.copyWith(reason: '');
    } else {
      state = state.copyWith(result: '設置義務はありません');
      state = state.copyWith(reason: 'ただし、市町村条例や危険物施設には注意してください');
    }
  }
}

/// テキスト入力初期化
final fireAlarmReqSqTxtCtrlProvider = StateProvider((ref) {
  String sq = ref.watch(fireAlarmRequireProvider).sq.toString();
  return TextEditingController(text: sq);
});
