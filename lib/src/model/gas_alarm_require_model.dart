import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'gas_alarm_require_model.freezed.dart';
part 'gas_alarm_require_model.g.dart';

/// ガス漏れ警報器設置義務判別計算のクラス
@freezed
class GasAlarmRequireClass with _$GasAlarmRequireClass {
  const factory GasAlarmRequireClass({
    /// 入力
    required FirePreventPropertyEnum firePreventProperty, // 防火対象物種類
    required int sq, // 延べ面積
    required int sqFloor, // 床面積
    required bool isHotSpring, // 温泉施設
    required bool isUnderGround, // 地階

    /// 出力
    required String result, // ガス漏れ警報器設置が義務かどうか
    required String reason, // ガス漏れ警報器が必要な理由
  }) = _GasAlarmRequireClass;

  /// from Json
  factory GasAlarmRequireClass.fromJson(Map<String, dynamic> json) =>
      _$GasAlarmRequireClassFromJson(json);
}
