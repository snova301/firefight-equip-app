import 'package:freezed_annotation/freezed_annotation.dart';

part 'setting_model.freezed.dart';
part 'setting_model.g.dart';

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
