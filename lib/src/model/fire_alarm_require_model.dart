import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fire_alarm_require_model.freezed.dart';
part 'fire_alarm_require_model.g.dart';

/// 消火器設置義務判別計算のクラス
@freezed
class FireAlarmRequireClass with _$FireAlarmRequireClass {
  const factory FireAlarmRequireClass({
    /// 入力
    required FirePreventPropertyEnum firePreventProperty, // 防火対象物種類
    required int sq, // 面積
    required bool isNoWindow, // 無窓階
    required bool isLodge, // 宿泊可能か
    required bool isCombust, // 少量危険物、指定可燃物
    required String floor, // 階(地階、11F以上もここで選択)

    /// 出力
    required String result, // 自火報設置が義務かどうか
    required String reason, // 自火報が必要な理由
  }) = _FireAlarmRequireClass;

  /// from Json
  factory FireAlarmRequireClass.fromJson(Map<String, dynamic> json) =>
      _$FireAlarmRequireClassFromJson(json);
}
