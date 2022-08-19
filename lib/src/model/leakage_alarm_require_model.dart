import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'leakage_alarm_require_model.freezed.dart';
part 'leakage_alarm_require_model.g.dart';

/// 漏電火災警報器設置義務判別計算のクラス
@freezed
class LeakageAlarmRequireClass with _$LeakageAlarmRequireClass {
  const factory LeakageAlarmRequireClass({
    /// 入力
    required FirePreventPropertyEnum firePreventProperty, // 防火対象物種類
    required int sq, // 延べ面積
    required int sqFloor, // 床面積
    required bool isContractCurrent, // 最大契約電流が50A以上

    /// 出力
    required String result, // 漏電火災警報器設置が義務かどうか
    required String reason, // 漏電火災警報器が必要な理由
  }) = _LeakageAlarmRequireClass;

  /// from Json
  factory LeakageAlarmRequireClass.fromJson(Map<String, dynamic> json) =>
      _$LeakageAlarmRequireClassFromJson(json);
}
