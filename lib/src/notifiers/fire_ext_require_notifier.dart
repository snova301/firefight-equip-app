import 'package:firefight_equip/src/model/data_class.dart';
import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 配線リスト入力のProviderの定義
final fireExtRequireProvider =
    StateNotifierProvider<FireExtRequireNotifier, FireExtRequireClass>((ref) {
  return FireExtRequireNotifier();
});

/// 配線リスト入力のNotifierの定義
class FireExtRequireNotifier extends StateNotifier<FireExtRequireClass> {
  // 空のデータとして初期化
  FireExtRequireNotifier()
      : super(const FireExtRequireClass(
          firePreventProperty: FirePreventPropertyEnum.no1I,
          sq: 10,
          isNoWindow: false,
          isNeeded: false,
        ));

  /// 防火対象物の更新
  void updateFirePreventProperty(FirePreventPropertyEnum newProperty) {
    state = state.copyWith(firePreventProperty: newProperty);
  }

  /// 無窓階真偽値の更新
  void updateIsNoWindow(bool newBool) {
    state = state.copyWith(isNoWindow: newBool);
  }

  // /// 全データの更新
  // void updateAll(Map<String, FireExtRequireClass> data) {
  //   state = {...data};
  // }

}

final textInputProvider = StateProvider((ref) => TextEditingController());

final fireExtReqOutputProvider = StateProvider((ref) {
  if (ref.watch(fireExtRequireProvider).isNeeded) {
    return '設置義務があります';
  }
  return '設置義務はありません';
});
