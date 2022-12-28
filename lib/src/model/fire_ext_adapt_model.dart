import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fire_ext_adapt_model.freezed.dart';
part 'fire_ext_adapt_model.g.dart';

/// 消火器適応火災のクラス
@freezed
class FireExtAdaptClass with _$FireExtAdaptClass {
  const factory FireExtAdaptClass({
    /// 入力
    required FireExtAdaptEnum fireExtAdapt, // 適応火災

    /// 出力
    required String resultA, // 消火器がA火災に適応するか
    required String resultB, // 消火器がA火災に適応するか
    required String resultC, // 消火器がA火災に適応するか
  }) = _FireExtAdaptClass;

  /// from Json
  factory FireExtAdaptClass.fromJson(Map<String, dynamic> json) =>
      _$FireExtAdaptClassFromJson(json);
}
