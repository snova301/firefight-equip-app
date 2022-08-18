import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fire_ext_capacity_model.freezed.dart';
part 'fire_ext_capacity_model.g.dart';

/// 消火器具能力単位計算のクラス
@freezed
class FireExtCapacityClass with _$FireExtCapacityClass {
  const factory FireExtCapacityClass({
    /// 入力
    required FirePreventPropertyEnum firePreventProperty, // 防火対象物種類
    required int sq, // 延べ面積
    required int sqElectrocity, // 電気設備面積
    required int sqBoiler, // ボイラー室等の多量の火気を使用する部分の面積
    required bool isFireproof, // 主要構造部が耐火構造でかつ壁及び天井が難燃材料
    required bool isCombust, // 少量危険物、指定可燃物

    /// 出力
    required double resultA, // A火災の能力単位
    required String resultB, // B火災の能力単位
    required int resultC, // C火災の消火器の本数
    required int resultBoiler, // ボイラー室への付加設置
  }) = _FireExtCapacityClass;

  /// from Json
  factory FireExtCapacityClass.fromJson(Map<String, dynamic> json) =>
      _$FireExtCapacityClassFromJson(json);
}
