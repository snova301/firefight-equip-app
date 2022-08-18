import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fire_alarm_require_model.freezed.dart';
part 'fire_alarm_require_model.g.dart';

/// 自火報設置義務判別計算のクラス
@freezed
class FireAlarmRequireClass with _$FireAlarmRequireClass {
  const factory FireAlarmRequireClass({
    /// 入力
    required FirePreventPropertyEnum firePreventProperty, // 防火対象物種類
    required int sq, // 延べ面積
    required int sqFloor, // 床面積
    required bool isNoWindow, // 無窓階
    required bool isLodge, // 宿泊可能か(6項イ、6項ハ、16項の2の判断に使用)
    required bool isCombust, // 指定可燃物
    required bool isSprinkler, // 閉鎖型スプリンクラー設備、水噴霧消火設備又は泡消火設備
    required bool isOneStairs, // 特定1階段等防火対象物
    required String floor, // 階(地階、11F以上もここで選択)
    required String usedType, // その階の用途(通信機器室、道路、駐車場)

    /// 出力
    required String result, // 自火報設置が義務かどうか
    required String reason, // 自火報が必要な理由
  }) = _FireAlarmRequireClass;

  /// from Json
  factory FireAlarmRequireClass.fromJson(Map<String, dynamic> json) =>
      _$FireAlarmRequireClassFromJson(json);
}
