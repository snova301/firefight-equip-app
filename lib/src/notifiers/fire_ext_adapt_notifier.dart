import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:firefight_equip/src/model/fire_ext_adapt_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 消火器適応火災のProviderの定義
final fireExtAdaptProvider =
    StateNotifierProvider<FireExtAdaptNotifier, FireExtAdaptClass>((ref) {
  return FireExtAdaptNotifier();
});

/// 消火器適応火災のNotifierの定義
class FireExtAdaptNotifier extends StateNotifier<FireExtAdaptClass> {
  // 空のデータとして初期化
  FireExtAdaptNotifier()
      : super(
          FireExtAdaptClass(
            fireExtAdapt: FireExtAdaptEnum.none,
            resultA: FireExtAdaptEnum.none.resultA,
            resultB: FireExtAdaptEnum.none.resultB,
            resultC: FireExtAdaptEnum.none.resultC,
          ),
        );

  /// 消火器種類の更新
  void updateFireExt(FireExtAdaptEnum newVal) {
    state = state.copyWith(fireExtAdapt: newVal);
    state = state.copyWith(resultA: newVal.resultA);
    state = state.copyWith(resultB: newVal.resultB);
    state = state.copyWith(resultC: newVal.resultC);
  }
}
