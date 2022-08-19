import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/model/fire_ext_capacity_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 消火器能力単位計算のProviderの定義
final fireExtCapacityProvider =
    StateNotifierProvider<FireExtCapacityNotifier, FireExtCapacityClass>((ref) {
  return FireExtCapacityNotifier();
});

/// 配線リスト入力のNotifierの定義
class FireExtCapacityNotifier extends StateNotifier<FireExtCapacityClass> {
  // 空のデータとして初期化
  FireExtCapacityNotifier()
      : super(const FireExtCapacityClass(
          firePreventProperty: FirePreventPropertyEnum.no1I,
          sq: 0,
          sqElectrocity: 0,
          sqBoiler: 0,
          isFireproof: false,
          isCombust: false,
          resultA: 0,
          resultB: '',
          resultC: 0,
          resultBoiler: 0,
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

  /// 電気設備面積の更新
  void updateSqElectrocity(String newVal) {
    try {
      state = state.copyWith(sqElectrocity: int.parse(newVal));
    } catch (e) {
      state = state.copyWith(sqElectrocity: 0);
    }
  }

  /// ボイラー室等の多量の火気を使用する部分の面積の更新
  void updateSqBoiler(String newVal) {
    try {
      state = state.copyWith(sqBoiler: int.parse(newVal));
    } catch (e) {
      state = state.copyWith(sqBoiler: 0);
    }
  }

  /// 倍読み真偽値の更新
  /// 主要構造部を耐火構造とし、かつ、壁及び天井の室内に面する部分の仕上げを難燃材料でした防火対象物
  void updateIsFireproof(bool newBool) {
    state = state.copyWith(isFireproof: newBool);
  }

  /// 指定可燃物真偽値の更新
  void updateIsCombust(bool newBool) {
    state = state.copyWith(isCombust: newBool);
  }

  /// 計算実行
  void run() {
    /// 読み込み
    final firePreventProperty = state.firePreventProperty;

    /// 主要構造部が耐火構造でかつ壁及び天井が難燃材料なら2倍読み
    final intFireproof = state.isFireproof ? 2 : 1;

    /// 算定基準面積
    int sqStd = 0;

    /// 入力条件をもとに判断
    if (
        // 算定基準面積が50m2
        // 1項イ、2項、16の2項、16の3項、17項、20項
        firePreventProperty == FirePreventPropertyEnum.no1I ||
            firePreventProperty == FirePreventPropertyEnum.no2I ||
            firePreventProperty == FirePreventPropertyEnum.no2Ro ||
            firePreventProperty == FirePreventPropertyEnum.no2Ha ||
            firePreventProperty == FirePreventPropertyEnum.no2Ni ||
            firePreventProperty == FirePreventPropertyEnum.no16No2 ||
            firePreventProperty == FirePreventPropertyEnum.no16No3 ||
            firePreventProperty == FirePreventPropertyEnum.no17) {
      sqStd = 50;
    } else if (
        // 延べ面積150m2以上で設置義務がある防火対象物
        // 1項ロ、4項、5項、6項イ4、6項ハ、6項ニ、9項、12項、13項、14項
        firePreventProperty == FirePreventPropertyEnum.no1Ro ||
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
            firePreventProperty == FirePreventPropertyEnum.no9I ||
            firePreventProperty == FirePreventPropertyEnum.no9Ro ||
            firePreventProperty == FirePreventPropertyEnum.no12I ||
            firePreventProperty == FirePreventPropertyEnum.no12Ro ||
            firePreventProperty == FirePreventPropertyEnum.no13I ||
            firePreventProperty == FirePreventPropertyEnum.no13Ro ||
            firePreventProperty == FirePreventPropertyEnum.no14) {
      sqStd = 100;
    } else if (
        // 延べ面積300m2以上で設置義務がある防火対象物
        // 7項、8項、10項、11項、15項
        firePreventProperty == FirePreventPropertyEnum.no7 ||
            firePreventProperty == FirePreventPropertyEnum.no8 ||
            firePreventProperty == FirePreventPropertyEnum.no10 ||
            firePreventProperty == FirePreventPropertyEnum.no11 ||
            firePreventProperty == FirePreventPropertyEnum.no15) {
      sqStd = 200;
    } else if (
        // 複合用途防火対象物は当該用途の基準による
        firePreventProperty == FirePreventPropertyEnum.no16I ||
            firePreventProperty == FirePreventPropertyEnum.no16Ro) {
      sqStd = 0;
    } else {
      // 18項、19項、20項は規定なし
      sqStd = 0;
    }

    /// A消火器の基本の能力単位計算
    if (sqStd != 0) {
      /// 算定基準面積が0ではない
      final resultA = state.sq / sqStd / intFireproof;
      state = state.copyWith(resultA: resultA);
    } else {
      /// 算定基準面積が0のとき
      state = state.copyWith(resultA: 0);
    }

    /// B消火器必要
    state = state.copyWith(
        resultB: state.isCombust ? '使用する危険物または指定可燃物に適応した消火器が必要です' : '');

    /// C消火器の本数(切り上げ)
    final resultC = (state.sqElectrocity / 100).ceil();
    state = state.copyWith(resultC: resultC);

    /// ボイラー室のA消火器付加設置の本数(切り上げ)
    final resultBoiler = (state.sqBoiler / 25).ceil();
    state = state.copyWith(resultBoiler: resultBoiler);
  }
}

/// 面積テキスト入力初期化
final fireExtCapaSqTxtCtrlProvider = StateProvider((ref) {
  String sq = ref.watch(fireExtCapacityProvider).sq.toString();
  return TextEditingController(text: sq);
});

/// 電気設備面積テキスト入力初期化
final fireExtCapaSqElecTxtCtrlProvider = StateProvider((ref) {
  String sqElec = ref.watch(fireExtCapacityProvider).sqElectrocity.toString();
  return TextEditingController(text: sqElec);
});

/// ボイラー室面積テキスト入力初期化
final fireExtCapaSqBoilerTxtCtrlProvider = StateProvider((ref) {
  String sqBoiler = ref.watch(fireExtCapacityProvider).sqBoiler.toString();
  return TextEditingController(text: sqBoiler);
});
