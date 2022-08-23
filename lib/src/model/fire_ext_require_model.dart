import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fire_ext_require_model.freezed.dart';
part 'fire_ext_require_model.g.dart';

/// 消火器設置義務判別計算のクラス
@freezed
class FireExtRequireClass with _$FireExtRequireClass {
  const factory FireExtRequireClass({
    /// 入力
    required FirePreventPropertyEnum firePreventProperty, // 防火対象物種類
    required int sq, // 延べ面積
    required int sqFloor, // 床面積
    required bool isNoWindow, // 地階、無窓階、3F以上
    required bool isCombust, // 少量危険物、指定可燃物
    required bool isUsedFire, // 火を使用する器具(防火対象物 3項の判断に使用)

    /// 出力
    required String result, // 消火器設置が義務かどうか
    required String reason, // 消火器具が必要な理由
  }) = _FireExtRequireClass;

  /// from Json
  factory FireExtRequireClass.fromJson(Map<String, dynamic> json) =>
      _$FireExtRequireClassFromJson(json);
}
