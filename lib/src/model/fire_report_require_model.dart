import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fire_report_require_model.freezed.dart';
part 'fire_report_require_model.g.dart';

/// 火災通報装置設置義務判別計算のクラス
@freezed
class FireReportRequireClass with _$FireReportRequireClass {
  const factory FireReportRequireClass({
    /// 入力
    required FirePreventPropertyEnum firePreventProperty, // 防火対象物種類
    required int sq, // 延べ面積
    required bool isDistance, // 消防機関から著しく離れた場所その他総務省令で定める場所
    required bool isAlwaysReport, // 消防機関へ常時通報することができる電話を設置

    /// 出力
    required String result, // 火災通報装置設置が義務かどうか
    required String reason, // 火災通報装置が必要な理由
  }) = _FireReportRequireClass;

  /// from Json
  factory FireReportRequireClass.fromJson(Map<String, dynamic> json) =>
      _$FireReportRequireClassFromJson(json);
}
