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
          isNeeded: false,
        ));
  // FireExtRequireNotifier({FireExtRequireClass(firePreventProperty:FirePreventPropertyEnum.no1I,sq: 10,isNeeded: false,)});

  /// データの更新
  void updateFirePreventProperty(FirePreventPropertyEnum newProperty) {
    state = state.copyWith(firePreventProperty: newProperty);
  }

  // /// 全データの更新
  // void updateAll(Map<String, FireExtRequireClass> data) {
  //   state = {...data};
  // }

  // /// 削除
  // void remove(String id) {
  //   /// 新規追加または変更
  //   Map temp = state;
  //   temp.remove(id);
  //   state = {...temp};
  // }

  // /// データを初期化
  // void removeAll() {
  //   state = {};
  // }
}

final textInputProvider = StateProvider((ref) => TextEditingController());
