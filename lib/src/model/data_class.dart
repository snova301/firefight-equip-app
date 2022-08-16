import 'package:flutter/foundation.dart';
import 'package:firefight_equip/src/model/enum_class.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_class.freezed.dart';
part 'data_class.g.dart';

/// 消火器設置義務判別計算のクラス
@freezed
class FireExtRequireClass with _$FireExtRequireClass {
  const factory FireExtRequireClass({
    /// 入力
    required FirePreventPropertyEnum firePreventProperty, // 防火対象物種類
    required int sq, // 面積
    required bool isNoWindow, // 地階、無窓階、3F以上

    /// 出力
    /// 消火器設置が義務
    required bool isNeeded,
  }) = _FireExtRequireClass;

  /// from Json
  factory FireExtRequireClass.fromJson(Map<String, dynamic> json) =>
      _$FireExtRequireClassFromJson(json);
}

/// 設定用のデータクラス
@freezed
class SettingDataClass with _$SettingDataClass {
  const factory SettingDataClass({
    /// ダークモード
    required bool darkMode,
  }) = _SettingDataClass;

  /// from Json
  factory SettingDataClass.fromJson(Map<String, dynamic> json) =>
      _$SettingDataClassFromJson(json);
}



// /// WiringListページ間の設定クラス
// class WiringListSettingDataClass {
//   /// 備考
//   TextEditingController remarksController;

//   WiringListSettingDataClass({
//     required this.remarksController,
//   });
// }

// /// Map型に変換
// Map toMap() => {
//       'current': current,
//       'cableSize': cableSize,
//       'voltDrop': voltDrop,
//       'powerLoss': powerLoss,
//     };

// /// JSONオブジェクトを代入
// CableDesignData.fromJson(Map json)
//     : phase = json['phase'],
//       current = json['current'],
//       cableSize = json['cableSize'],
//       voltDrop = json['voltDrop'],
//       powerLoss = json['powerLoss'];